# Copyright (C) 2017 Digi International Inc.

RPI_SENSEHAT_PACKAGES ?= "python-evdev python-sense-hat-examples"

ADAFRUIT_PITFT_ENABLED = "${@bb.utils.contains_any('ADAFRUIT_PITFT_DISPLAY', [ 'ADAFRUIT_PITFT_22' , 'ADAFRUIT_PITFT_28' , 'ADAFRUIT_PITFT_35' ], '1', '', d)}"

# Add RPi Sense Hat packages
IMAGE_INSTALL_append = "${@oe.utils.conditional('RPI_SENSEHAT_ENABLED', '1', ' ${RPI_SENSEHAT_PACKAGES}', '', d)}"
IMAGE_INSTALL_append = "${@oe.utils.conditional('ADAFRUIT_PITFT_ENABLED', '1', ' digi-images evtest tslib-tests tslib-calibrate tslib-conf', '', d)}"
