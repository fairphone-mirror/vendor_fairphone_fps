include device/qcom/volcano/BoardConfig.mk

ifeq ($(BUILD_WITH_RELEASEKEY),true)
ifeq ($(BOARD_AVB_ENABLE), true)
BOARD_AVB_RECOVERY_KEY_PATH := vendor/fairphone/release-keys/certificate/avb/boot_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
endif
#BOARD_AVB_BOOT_KEY_PATH := vendor/fairphone/release-keys/certificate/avb/boot_rsa4096.pem
#BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_KEY_PATH := vendor/fairphone/release-keys/certificate/avb/boot_rsa4096.pem
BOARD_AVB_ALGORITHM := SHA256_RSA4096
endif

include device/fairphone/common/BoardConfigCommon.mk

ifneq ($(wildcard device/fairphone/fps-kernel/extra_cmdline),)
BOARD_KERNEL_CMDLINE += $(file < device/fairphone/fps-kernel/extra_cmdline)
endif
ifneq ($(wildcard device/fairphone/fps-kernel/extra_bootconfig),)
BOARD_BOOTCONFIG += $(file < device/fairphone/fps-kernel/extra_bootconfig)
endif
