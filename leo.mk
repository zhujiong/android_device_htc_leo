#
# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# This is the product configuration for a generic GSM leo,
# not specialized for any geography.
#


## (1) First, the most specific values, i.e. the aspects that are specific to GSM

PRODUCT_COPY_FILES += \
    device/htc/leo/init.leo.rc:root/init.leo.rc \

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=240 \
    rild.libpath=/system/lib/libhtc_ril.so \
    ro.ril.ecc.HTC-ELL=92,93,94 \
    ro.ril.ecc.HTC-WWE=999 \
    ro.ril.enable.a52.HTC-ITA=1 \
    ro.ril.enable.a53.HTC-ITA=1 \
    ro.ril.enable.a52=0 \
    ro.ril.enable.a53=1 \
    ro.ril.enable.dtm = 1 \
    ro.ril.gprsclass = 12 \
    ro.ril.hsdpa.category=8 \
    ro.ril.hsupa.category=5 \
    ro.ril.hsxpa=2 \
    mobiledata.interfaces=rmnet0,rmnet1,rmnet2,ppp \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=15

# Default network type.
# 0 => WCDMA preferred.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=0


# Set default_france.acdb to audio_ctl driver if the ro.cid is HTC__203
PRODUCT_PROPERTY_OVERRIDES += \
    ro.ril.enable.prl.recognition=1

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072


# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PROPERTY_OVERRIDES += \
    ro.media.dec.jpeg.memcap=20000000

# This is a high density device with more memory, so larger vm heaps for it.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=32m

# leo have huge 250Mb unwritable system and small 50Mb cache .
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-data-only=1

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/htc/leo/leo-vendor.mk)


DEVICE_PACKAGE_OVERLAYS += device/htc/leo/overlay

PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml

# media config xml file
PRODUCT_COPY_FILES += \
    device/htc/leo/media_profiles.xml:system/etc/media_profiles.xml

PRODUCT_PACKAGES += \
    sensors.htcleo \
    lights.htcleo \
    librs_jni \
    gralloc.qsd8k \
    copybit.qsd8k \
    leo-reference-ril \
    gps.leo



# leo uses high-density artwork where available 
PRODUCT_LOCALES := hdpi

PRODUCT_COPY_FILES += \
    device/htc/leo/vold.fstab:system/etc/vold.fstab

# Keylayouts
PRODUCT_COPY_FILES += \
    device/htc/leo/leo-keypad.kl:system/usr/keylayout/leo-keypad.kl \
    device/htc/leo/leo-keypad.kcm.bin:system/usr/keychars/leo-keypad.kcm.bin \
    device/htc/leo/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl

# Firmware
PRODUCT_COPY_FILES += \
    device/htc/leo/firmware/fw_bcm4329.bin:system/etc/firmware/fw_bcm4329.bin \
    device/htc/leo/firmware/fw_bcm4329_apsta.bin:system/etc/firmware/fw_bcm4329_apsta.bin

#GSM APN LIST
PRODUCT_COPY_FILES += \
vendor/cyanogen/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml


PRODUCT_COPY_FILES += \
    device/htc/leo/modules/bcm4329.ko:system/lib/modules/bcm4329.ko \
    device/htc/leo/modules/cifs.ko:system/lib/modules/cifs.ko \
    device/htc/leo/modules/msm_rmnet.ko:system/lib/modules/msm_rmnet.ko \
    device/htc/leo/modules/nls_utf8.ko:system/lib/modules/nls_utf8.ko \
    device/htc/leo/modules/tun.ko:system/lib/modules/tun.ko \
    device/htc/leo/modules/fuse.ko:system/lib/modules/fuse.ko

PRODUCT_COPY_FILES += \
    device/htc/leo/kernel:boot/zImage \
    device/htc/leo/initrd.gz:boot/initrd.gz \

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/htc/leo/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_as_supl.mk)

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# media profiles and capabilities spec
$(call inherit-product, device/htc/leo/media_a1026.mk)

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)

PRODUCT_NAME := htc_leo
PRODUCT_DEVICE := leo
