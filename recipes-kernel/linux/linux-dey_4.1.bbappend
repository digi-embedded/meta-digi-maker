# Copyright (C) 2017 Digi International Inc.

FILESEXTRAPATHS_prepend := "${THISDIR}/${BP}:"

SRC_URI_append_ccimx6ulstarter = " \
    ${@base_conditional('RPI_SENSEHAT_ENABLED', '1', ' file://0001-ARM-dts-ccimx6ulstarter-add-support-for-Sense-HAT.patch', '', d)} \
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

do_configure_prepend() {
	if [ "${RPI_SENSEHAT_ENABLED}" = "1" ]; then
		rpisensehat_kernel_preconfigure
	fi
}
