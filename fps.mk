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

ifneq ("$(wildcard device/fairphone/fps-kernel/vendor_dlkm/system_dlkm.modules.blocklist)", "")
  PRODUCT_COPY_FILES += device/fairphone/fps-kernel/vendor_dlkm/system_dlkm.modules.blocklist:$(TARGET_COPY_OUT_VENDOR_DLKM)/lib/modules/system_dlkm.modules.blocklist
endif

# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_NAME)/$(KERNEL_MODULES_INSTALL)/lib/modules

# audio smart pa aw88261 i2s_stereo_16 firmware
PRODUCT_COPY_FILES += \
    device/fairphone/fps/audio/aw882xx_acf.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/aw882xx_acf.bin


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
