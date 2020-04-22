INSTALL_TARGET_PROCESSES = SpringBoard

THEOS_DEVICE_IP = 192.168.1.123

ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MailPatch

MailPatch_FILES = Tweak.xm
MailPatch_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
