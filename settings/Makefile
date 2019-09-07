include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = bhbsettings

bhbsettings_FILES = BHBRootListController.m
bhbsettings_INSTALL_PATH = /Library/PreferenceBundles
bhbsettings_FRAMEWORKS = UIKit
bhbsettings_PRIVATE_FRAMEWORKS = Preferences
bhbsettings_CFLAGS = -fobjc-arc
bhbsettings_LIBRARIES = colorpicker
include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/bhbsettings.plist$(ECHO_END)
