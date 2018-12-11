DESCRIPTION = "Digi images and logo collection"
SECTION = "examples"
LICENSE = "CLOSED"

SRC_URI = " \
    file://digi_logo_320x240.ppm \
    file://digi_logo_320x480.ppm \
    file://cc6ul_320x240.ppm \
    file://cc6ul_320x480.ppm \
"

inherit allarch

do_compile[noexec] = "1"

do_install() {
    install -d ${D}${datadir}/pixmaps
    install -m 0755 ${WORKDIR}/*.ppm ${D}${datadir}/pixmaps
}

