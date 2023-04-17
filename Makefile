ARCHS = arm64 arm64e
TARGET = iphone:clang:16.5:15.0
# PREFIX = $(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/
PREFIX = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/
SYSROOT = $(THEOS)/sdks/iPhoneOS14.5.sdk
# TARGET = simulator:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Unsigncuts

Unsigncuts_FILES = Tweak.xm
Unsigncuts_CFLAGS = -fobjc-arc
Unsigncuts_EXTRA_FRAMEWORKS = Cephei
Unsigncuts_USE_SUBSTRATE = 0
Unsigncuts_LOGOS_DEFAULT_GENERATOR = internal
# THEOS_PACKAGE_SCHEME=rootless

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += unsigncutsprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
