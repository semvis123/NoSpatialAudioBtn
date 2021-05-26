TARGET := iphone:clang:13.3.1
INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_DEVICE_IP = 192.168.2.1
include $(THEOS)/makefiles/common.mk
ARCHS = arm64 arm64e
TWEAK_NAME = NoSpatialAudioBtn
NoSpatialAudioBtn_FILES = Tweak.xm
NoSpatialAudioBtn_CFLAGS = -fobjc-arc -std=c++17
NoSpatialAudioBtn_FRAMEWORKS = Foundation UIKit
include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += NoSpatialAudioBtnPreferences
include $(THEOS_MAKE_PATH)/aggregate.mk