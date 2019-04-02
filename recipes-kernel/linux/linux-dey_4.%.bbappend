# Copyright (C) 2017-2018 Digi International Inc.

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

ADAFRUIT_PITFT_ENABLED = "${@bb.utils.contains_any('ADAFRUIT_PITFT_DISPLAY', [ 'ADAFRUIT_PITFT_22' , 'ADAFRUIT_PITFT_28' , 'ADAFRUIT_PITFT_35' ], '1', '', d)}"

ADAFRUIT_PITFT_TOUCH_ENABLED = "${@d.getVar('ADAFRUIT_PITFT_CAP_TOUCH') or d.getVar('ADAFRUIT_PITFT_RES_TOUCH')}"

ADAFRUIT_PIFTF_ROTATION ?= "270"
ADAFRUIT_PIFTF_BUSNUM ?= "2"

SRC_URI_append_ccimx6ulstarter = " \
    ${@oe.utils.conditional('RPI_SENSEHAT_ENABLED', '1', ' file://0001-ARM-dts-ccimx6ulstarter-add-support-for-Sense-HAT.patch', '', d)} \
    ${@oe.utils.conditional('ADAFRUIT_PITFT_ENABLED', '1', 'file://0001-ARM-dts-ccimx6ulstarter-Add-support-for-Adafruit-PiT.patch', '', d)} \
    ${@oe.utils.conditional('ADAFRUIT_PITFT_ENABLED', '1', 'file://0002-ARM-dts-ccimx6ulstarter-Disable-CAN1-for-Adafruit-di.patch', '', d)} \
    ${@bb.utils.contains('ADAFRUIT_PITFT_DISPLAY', 'ADAFRUIT_PITFT_35', 'file://0003-fbtft_device-Add-support-for-the-Adafruit-HX8357D-3..patch', '', d)} \
    ${@bb.utils.contains('ADAFRUIT_PITFT_DISPLAY', 'ADAFRUIT_PITFT_22', 'file://0004-fbtft_device-Add-support-for-the-Adafruit-ILI9340-2..patch', '', d)} \
    ${@bb.utils.contains('ADAFRUIT_PITFT_DISPLAY', 'ADAFRUIT_PITFT_28', 'file://0005-fbtft_device-Add-support-for-the-Adafruit-ILI9341-2..patch', '', d)} \
    ${@bb.utils.contains('ADAFRUIT_PITFT_CAP_TOUCH', '1', 'file://0006-ARM-dts-ccimx6ulstarter-Add-support-for-the-Focaltec.patch', '', d)} \
    ${@bb.utils.contains('ADAFRUIT_PITFT_RES_TOUCH', '1', 'file://0007-ARM-dts-ccimx6ulstarter-Add-support-for-STMPE610-res.patch', '', d)} \
"

KERNEL_MODULE_AUTOLOAD += " \
    ${@oe.utils.conditional('ADAFRUIT_PITFT_ENABLED', '1', 'fbtft_device', '', d)} \
"
KERNEL_MODULE_PROBECONF += " \
    ${@oe.utils.conditional('ADAFRUIT_PITFT_ENABLED', '1', 'fbtft_device', '', d)} \
"
module_conf_fbtft_device = " \
    ${@bb.utils.contains('ADAFRUIT_PITFT_DISPLAY', 'ADAFRUIT_PITFT_22', 'options fbtft_device name=adafruit22a_${MACHINE} busnum=${ADAFRUIT_PIFTF_BUSNUM} rotate=${ADAFRUIT_PIFTF_ROTATION}', '', d)} \
    ${@bb.utils.contains('ADAFRUIT_PITFT_DISPLAY', 'ADAFRUIT_PITFT_28', 'options fbtft_device name=adafruit28_${MACHINE} busnum=${ADAFRUIT_PIFTF_BUSNUM} rotate=${ADAFRUIT_PIFTF_ROTATION}', '', d)} \
    ${@bb.utils.contains('ADAFRUIT_PITFT_DISPLAY', 'ADAFRUIT_PITFT_35', 'options fbtft_device name=adafruit35_${MACHINE} busnum=${ADAFRUIT_PIFTF_BUSNUM} rotate=${ADAFRUIT_PIFTF_ROTATION}', '', d)} \
"

#
# Enable RPi Sense Hat support in kernel configuration
#
# 'kernel_conf_variable' comes from 'meta-freescale' layer
#
rpisensehat_kernel_preconfigure() {
	mkdir -p ${B}

	# Enable RPi Sense Hat support
	kernel_conf_variable INPUT_JOYSTICK y
	kernel_conf_variable JOYSTICK_RPISENSE y
	kernel_conf_variable FB_RPISENSE y

	# Disable framebuffer console and logo (don't work on Sense Hat)
	kernel_conf_variable FRAMEBUFFER_CONSOLE n
	kernel_conf_variable LOGO n

	sed -e "${CONF_SED_SCRIPT}" < '${WORKDIR}/defconfig' >> '${B}/.config'
}

#
# Enable Adafruit PiTFT Hat support in kernel configuration
#
# 'kernel_conf_variable' comes from 'meta-freescale' layer
#
adafruitpitfthat_kernel_preconfigure() {
	mkdir -p ${B}

	# Enable RPi Sense Hat support
	kernel_conf_variable FB_TFT y
	kernel_conf_variable FB_TFT_ILI9340 y
	kernel_conf_variable FB_TFT_ILI9341 y
	kernel_conf_variable FB_TFT_HX8357D y
	kernel_conf_variable FB_FLEX y
	kernel_conf_variable FB_TFT_FBTFT_DEVICE m

	# Disable custom logo (too small display)
	kernel_conf_variable LOGO n

	sed -e "${CONF_SED_SCRIPT}" < '${WORKDIR}/defconfig' >> '${B}/.config'
}

adafruitpitfthat_touch_kernel_preconfigure() {
        mkdir -p ${B}

        kernel_conf_variable TOUCHSCREEN_EDT_FT5X06 y
        kernel_conf_variable MFD_STMPE y
        kernel_conf_variable TOUCHSCREEN_STMPE y
        kernel_conf_variable STMPE_SPI y
}

do_configure_prepend() {
	if [ "${RPI_SENSEHAT_ENABLED}" = "1" ]; then
		rpisensehat_kernel_preconfigure
	fi
	if [ "${ADAFRUIT_PITFT_ENABLED}" = "1" ]; then
		adafruitpitfthat_kernel_preconfigure
	        if [ "${ADAFRUIT_PITFT_TOUCH_ENABLED}" = "1" ]; then
                    adafruitpitfthat_touch_kernel_preconfigure
	        fi
        fi
}
