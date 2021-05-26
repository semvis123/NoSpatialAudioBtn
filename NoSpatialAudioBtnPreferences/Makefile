TARGET := iphone:clang:13.3.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NoSpatialAudioBtnPreferences

NoSpatialAudioBtnPreferences_FILES = NSARootListController.m
NoSpatialAudioBtnPreferences_PRIVATE_FRAMEWORKS = Preferences
NoSpatialAudioBtnPreferences_INSTALL_PATH = /Library/PreferenceBundles
NoSpatialAudioBtnPreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
