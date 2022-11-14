ARCHS = arm64 arm64e
TARGET = iphone:clang:15.7.1:15.0
PREFIX = $(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/
SYSROOT = $(THEOS)/sdks/iPhoneOS14.5.sdk
# TARGET = simulator:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Unsigncuts

Unsigncuts_FILES = Tweak.xm
Unsigncuts_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk