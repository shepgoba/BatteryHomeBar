INSTALL_TARGET_PROCESSES = SpringBoard
DEBUG = 0
export TARGET=iphone:clang:11.2:11.0

export ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BatteryHomeBar

BatteryHomeBar_FILES = BatteryHomeBar.x
BatteryHomeBar_LIBRARIES = colorpicker
BatteryHomeBar_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += settings
include $(THEOS_MAKE_PATH)/aggregate.mk
