TARGET_USES_KERNEL_PLATFORM ?= true

ifndef TARGET_OUT_INTERMEDIATES
  TARGET_OUT_INTERMEDIATES := out/target/product/volcano/obj
endif
$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr:
	mkdir -p $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr


PRODUCT_COPY_FILES += $(KERNEL_PREBUILT_DIR)/Image:kernel
PRODUCT_COPY_FILES += $(KERNEL_PREBUILT_DIR)/System.map:$(KERNEL_PRODUCT_DIR)/System.map

# UAPI headers
TARGET_BOARD_KERNEL_HEADERS := $(KERNEL_PREBUILT_DIR)/kernel-headers

################################################################################
# Path to unsigned abl image
TARGET_BOARD_UNSIGNED_ABL_DIR := $(KERNEL_PREBUILT_DIR)/kernel-abl/abl-$(TARGET_BUILD_VARIANT)

################################################################################
# Path to system_dlkm artifacts directory
BOARD_SYSTEM_DLKM_SRC := $(KERNEL_PREBUILT_DIR)/system_dlkm

# DTBs
ifneq (,$(wildcard $(KERNEL_PREBUILT_DIR)/dtbs/))
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PREBUILT_DIR)/dtbs/dtbo.img
# AVF debug policy dtbo image
BOARD_PREBUILT_DPMIMAGE := $(KERNEL_PREBUILT_DIR)/kp-dtbs/dpm.img
# Path to prebuilt .dtb's used for dtb.img generation
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PREBUILT_DIR)/dtbs/
else
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PREBUILT_DIR)/dtbo.img
# Path to prebuilt .dtb's used for dtb.img generation
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PREBUILT_DIR)/
endif

################################################################################
# DLKMs
# get-kernel-modules:
# $1: directory inside KERNEL_PREBUILT_DIR to find the modules
define get-kernel-modules
$(if $(wildcard $(KERNEL_PREBUILT_DIR)/$(1)/modules.load), \
        $(addprefix $(KERNEL_PREBUILT_DIR)/$(1)/,$(notdir $(file < $(KERNEL_PREBUILT_DIR)/$(1)/modules.load))), \
        $(wildcard $(KERNEL_PREBUILT_DIR)/$(1)/*.ko))
endef

prepend-kernel-modules = $(eval $1 := $2 $(filter-out $2,$($1)))

first_stage_modules := $(call get-kernel-modules,.)
gki_modules := $(call get-kernel-modules,system_dlkm)
second_stage_modules := $(call get-kernel-modules,vendor_dlkm)

BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(first_stage_modules)
# Add gki_modules and second_stage_modules for recovery mode
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(gki_modules)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(second_stage_modules)

$(call prepend-kernel-modules,BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD,$(first_stage_modules))
$(call prepend-kernel-modules,BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD,$(first_stage_modules) $(second_stage_modules))

$(call prepend-kernel-modules,BOARD_GKI_KERNEL_MODULES,$(gki_modules))
$(call prepend-kernel-modules,BOARD_VENDOR_KERNEL_MODULES,$(second_stage_modules))

BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(wildcard $(KERNEL_PREBUILT_DIR)/vendor_dlkm/modules.blocklist)
# vendor ramdisk has second-stage modules for recovery
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(wildcard $(KERNEL_PREBUILT_DIR)/vendor_dlkm/modules.blocklist)

# remove CFG80211 & MAC80211 modules from recovey
# dependency on rfkill module
# rfkill module is GKI / System module
# GKI / System modules can't be loaded in recovery boot
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(filter-out $(KERNEL_PREBUILT_DIR)/vendor_dlkm/cfg80211.ko,$(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(filter-out $(KERNEL_PREBUILT_DIR)/vendor_dlkm/mac80211.ko,$(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD))

# Add recovery modules for non ab case
ifeq ($(BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE),false)
BOARD_RECOVERY_KERNEL_MODULES += $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD)
BOARD_RECOVERY_KERNEL_MODULES_BLOCKLIST_FILE := $(wildcard $(KERNEL_PREBUILT_DIR)/vendor_dlkm/modules.blocklist)
endif
