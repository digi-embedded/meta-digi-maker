# Copyright (C) 2017 Digi International Inc.

RPI_SENSEHAT_PACKAGES ?= "python-evdev python-sense-hat-examples"

# Add RPi Sense Hat packages
IMAGE_INSTALL_append = "${@base_conditional('RPI_SENSEHAT_ENABLED', '1', ' ${RPI_SENSEHAT_PACKAGES}', '', d)}"
