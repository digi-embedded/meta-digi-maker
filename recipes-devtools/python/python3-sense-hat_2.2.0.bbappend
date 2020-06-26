# Copyright (C) 2017-2020 Digi International Inc.

SRC_URI = "https://github.com/RPi-Distro/python-sense-hat/archive/v${PV}.tar.gz;downloadfilename=${BP}.tar.gz"

SRC_URI[md5sum] = "e6cb7fb39b765492850ae051fe7d3e7f"
SRC_URI[sha256sum] = "8c9780acb89942c2838fd8406e7e7f7836a8d8fb5debad74c0e9dd83e93a8a48"

S = "${WORKDIR}/python-sense-hat-${PV}"

#
# Install the RPi Sense Hat python examples
#
do_install_append() {
	install -d ${D}/opt/${BPN}
	cp -r examples ${D}/opt/${BPN}/
}

do_configure_prepend () {
    # use /usr/bin/env instead of version specific python
    for s in `find ${S}/examples/ -name '*.py'`; do
        sed -i 's,/usr/bin/python,/usr/bin/env python3,' "${s}"
    done
}

PACKAGES =+ "${BPN}-examples"

FILES_${BPN}-examples = "/opt/${BPN}"

RDEPENDS_${BPN}-examples = "${BPN}"
