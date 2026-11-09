TARGET := iphone:clang:latest:14.0
ARCHS := arm64 arm64e

THEOS_TOOLCHAIN_PATH ?= $(THEOS)/toolchain

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Sn0wpart

Sn0wpart_FILES = Tweak.xm
Sn0wpart_CFLAGS += -fobjc-arc
Sn0wpart_LDFLAGS += -lz
Sn0wpart_LDFLAGS += -framework UIKit
Sn0wpart_LDFLAGS += -framework QuartzCore
Sn0wpart_LDFLAGS += -framework CoreGraphics

include $(THEOS)/makefiles/tweak.mk
