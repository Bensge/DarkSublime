ARCHS = x86_64
#darwin-amd64

TARGET = macosx:clang:10.8:10.8

include theos/makefiles/common.mk

BUNDLE_NAME = darksublime
darksublime_FILES = Tweak.xm
darksublime_FRAMEWORKS = Foundation CoreGraphics AppKit
darksublime_INSTALL_PATH = $(HOME)/Library/Application Support/SIMBL/Plugins
darksublime_LOGOSFLAGS = -c generator=internal

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	cp Info.plist "$(THEOS_STAGING_DIR)$(HOME)/Library/Application Support/SIMBL/Plugins/darksublime.bundle/Contents/Info.plist"

after-stage::
	cp -R "_$(HOME)/Library/Application Support/SIMBL/Plugins/" "$(HOME)/Library/Application Support/SIMBL/Plugins/"

