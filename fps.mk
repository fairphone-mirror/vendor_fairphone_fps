TARGET_VENDOR := fairphone
TARGET_BASE_PRODUCT := fps
TARGET_BOOTLOADER_BOARD_NAME := fps
QCOM_BOARD_PLATFORMS += fps

TARGET_OUT_INTERMEDIATES := out/target/product/fps/obj
KERNEL_PREBUILT_DIR := device/fairphone/fps-kernel

include device/qcom/volcano/volcano.mk

PRODUCT_NAME := fps
PRODUCT_DEVICE := fps
PRODUCT_BRAND := Fairphone
PRODUCT_MODEL := Fairphone 6
PRODUCT_MANUFACTURER := Fairphone

# OVERRIDE_TARGET_PRODUCT change
OVERRIDE_TARGET_PRODUCT := FP6
OVERRIDE_TARGET_DEVICE := FP6
OVERRIDE_PLATFORM_VERSION := 16

PRODUCT_MODEL_FOR_ATTESTATION := Fairphone 6
PRODUCT_BRAND_FOR_ATTESTATION := Fairphone
PRODUCT_NAME_FOR_ATTESTATION := FP6

ifndef FAIRPHONE_REL_TYPE
  FAIRPHONE_REL_TYPE := DEV
endif
ifneq ($(wildcard $(TOPDIR)version/version.ini),)
  FAIRPHONE_BUILD_NUMBER := $(shell awk '/BUILD_AP_VER/ {print $$3}' $(TOPDIR)version/version.ini)
endif

ifneq ("$(wildcard device/fairphone/fps-kernel/vendor_dlkm/system_dlkm.modules.blocklist)", "")
  PRODUCT_COPY_FILES += device/fairphone/fps-kernel/vendor_dlkm/system_dlkm.modules.blocklist:$(TARGET_COPY_OUT_VENDOR_DLKM)/lib/modules/system_dlkm.modules.blocklist
endif

ifeq ($(BUILD_WITH_RELEASEKEY),true)
include vendor/fairphone/release-keys/fairphone_certificate.mk
endif

# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_NAME)/$(KERNEL_MODULES_INSTALL)/lib/modules

# audio smart pa aw88261 i2s_stereo_16 firmware
PRODUCT_COPY_FILES += \
    device/fairphone/fps/audio/aw882xx_acf.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/aw882xx_acf.bin
# audio smart pa firmware version
PRODUCT_COPY_FILES += \
    device/fairphone/fps/audio/aw882xx_ver:$(TARGET_COPY_OUT_VENDOR)/etc/aw882xx_ver

$(call inherit-product, device/fairphone/common/common_vendor.mk)

TARGET_BUILD_WIDEVINE := nonupdatable
TARGET_BUILD_WIDEVINE_USE_PREBUILT := true
-include vendor/widevine/libwvdrmengine/apex/device/device.mk

#----------------------------------------------------------------------
# fps haptic Firmware
#----------------------------------------------------------------------
PRODUCT_COPY_FILES += \
    device/fairphone/fps/haptic_hv/haptic_ram.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/haptic_ram.bin
PRODUCT_COPY_FILES += \
    device/fairphone/fps/haptic_hv/haptic_rtp.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/haptic_rtp.bin
PRODUCT_COPY_FILES += \
    device/fairphone/fps/haptic_hv/haptic_rtp_auto_sin.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/haptic_rtp_auto_sin.bin
PRODUCT_COPY_FILES += \
    device/fairphone/fps/haptic_hv/haptic_rtp_lighthouse.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/haptic_rtp_lighthouse.bin
PRODUCT_COPY_FILES += \
    device/fairphone/fps/haptic_hv/haptic_rtp_osc_24K_5s.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/haptic_rtp_osc_24K_5s.bin
PRODUCT_COPY_FILES += \
    device/fairphone/fps/haptic_hv/haptic_rtp_silk.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/haptic_rtp_silk.bin

#add by yangxuguang for Resize userdata [FPS-52]
PRODUCT_BUILD_USERDATA_IMAGE := false
BOARD_PREBUILT_USERDATAIMAGE := device/fairphone/fps/userdata.img
#add end
#set wlan mac [FPS-70]
PRODUCT_COPY_FILES += \
        device/fairphone/fps/setwlanmac.sh:$(TARGET_COPY_OUT_VENDOR)/bin/setwlanmac.sh

#FPS-3303 add ccode at vendor layer
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.odm.ccode=other