#include <sys/mman.h>

BOOL flushing;
BOOL appending;

%hookf(int, ftruncate, int fd, off_t length){
	int result = %orig;
	if(flushing && result == -1)
		abort();
	return result;
}

%hookf(void *, mmap, void *addr, size_t length, int prot, int flags, int fd, off_t offset){
	void *result = %orig;
	if(appending && result == (void *)-1)
		abort();
	return result;
}

%hook MFMutableData
-(void)_flushToDisk:(NSUInteger)length capacity:(NSUInteger)capacity{
	flushing = TRUE;
	%orig;
	flushing = FALSE;
}
-(void)appendBytes:(const void *)bytes length:(NSUInteger)length{
	appending = TRUE;
	%orig;
	appending = FALSE;
}
%end