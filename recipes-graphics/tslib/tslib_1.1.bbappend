# Copyright (C) 2018 Digi International Inc.

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " file://99-input-tslib.rules"

do_install_append() {
	if [ "${ADAFRUIT_PITFT_RES_TOUCH}" = "1" ]; then
		install -d ${D}${sysconfdir}/udev/rules.d/
		install -m 0644 ${WORKDIR}/99-input-tslib.rules ${D}${sysconfdir}/udev/rules.d/
	fi
}

FILES_${PN} += "${sysconfdir}/udev/rules.d/99-input-tslib.rules"
