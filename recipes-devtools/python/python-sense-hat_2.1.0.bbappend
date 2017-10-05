# Copyright (C) 2017 Digi International Inc.

SRC_URI = "https://github.com/RPi-Distro/${BPN}/archive/v${PV}.tar.gz;downloadfilename=${BP}.tar.gz"

SRC_URI[md5sum] = "eec4a6d9d718232f69475f17cd3864c2"
SRC_URI[sha256sum] = "fdc26c296955b7b7cca9279e4cbe309b835afbd4912e0b46cbeac20051ff84e5"

SRCNAME = "${BPN}"

#
# Install the RPi Sense Hat python examples
#
do_install_append() {
	install -d ${D}/opt/${BPN}
	cp -r examples ${D}/opt/${BPN}/
}

PACKAGES =+ "${BPN}-examples"

FILES_${BPN}-examples = "/opt/${BPN}"

RDEPENDS_${BPN}-examples = "${BPN}"
