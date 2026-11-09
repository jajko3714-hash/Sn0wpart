ARCHS := arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Sn0wpart

Sn0wpart_FILES = Tweak.xm
Sn0wpart_CFLAGS = -fobjc-arc
Sn0wpart_FRAMEWORKS = UIKit CoreGraphics QuartzCore

include $(THEOS)/makefiles/tweak.mk
