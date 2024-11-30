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
PRODUCT_MODEL := FpSpring
PRODUCT_MANUFACTURER := Fairphone

ifneq ("$(wildcard device/fairphone/fps-kernel/vendor_dlkm/system_dlkm.modules.blocklist)", "")
  PRODUCT_COPY_FILES += device/fairphone/fps-kernel/vendor_dlkm/system_dlkm.modules.blocklist:$(TARGET_COPY_OUT_VENDOR_DLKM)/lib/modules/system_dlkm.modules.blocklist
endif

# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_NAME)/$(KERNEL_MODULES_INSTALL)/lib/modules
