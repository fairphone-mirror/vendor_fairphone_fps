include device/qcom/volcano/BoardConfig.mk

ifneq ($(wildcard device/fairphone/fps-kernel/extra_cmdline),)
BOARD_KERNEL_CMDLINE += $(file < device/fairphone/fps-kernel/extra_cmdline)
endif
ifneq ($(wildcard device/fairphone/fps-kernel/extra_bootconfig),)
BOARD_BOOTCONFIG += $(file < device/fairphone/fps-kernel/extra_bootconfig)
endif
