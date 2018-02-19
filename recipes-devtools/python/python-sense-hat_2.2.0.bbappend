# Copyright (C) 2017, 2018 Digi International Inc.

SRC_URI = "https://github.com/RPi-Distro/${BPN}/archive/v${PV}.tar.gz;downloadfilename=${BP}.tar.gz"

SRC_URI[md5sum] = "e6cb7fb39b765492850ae051fe7d3e7f"
SRC_URI[sha256sum] = "8c9780acb89942c2838fd8406e7e7f7836a8d8fb5debad74c0e9dd83e93a8a48"

S = "${WORKDIR}/${BP}"

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
