ARCHS = arm64 arm64e
TARGET = iphone:clang:16.5:15.0
# PREFIX = $(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/
PREFIX = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/
SYSROOT = $(THEOS)/sdks/iPhoneOS14.5.sdk
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = UnsigncutsPrefs

UnsigncutsPrefs_FILES = UnsigncutsRootListController.m
UnsigncutsPrefs_FRAMEWORKS = UIKit
UnsigncutsPrefs_PRIVATE_FRAMEWORKS = Preferences
UnsigncutsPrefs_EXTRA_FRAMEWORKS += Cephei
UnsigncutsPrefs_INSTALL_PATH = /Library/PreferenceBundles
UnsigncutsPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
