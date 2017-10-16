OpenEmbedded/Yocto Digi Embedded Maker layer
============================================

This layer provides support for Raspberry Pi Hats for use with Digi hardware
and Yocto Digi's BSP layers.

This layer depends on the following layers:

https://github.com/digi-embedded/meta-digi
https://git.yoctoproject.org/cgit.cgi/meta-raspberrypi/


Supported Platforms
-------------------

  * Digi ConnectCore 6UL SBC Express
    * [Digi P/N CC-WMX6UL-START](http://www.digi.com/products/models/cc-wmx6ul-start)


Installation
------------
1. Install Digi Embedded Yocto distribution

    https://github.com/digi-embedded/dey-manifest#installing-digi-embedded-yocto

2. Clone *meta-raspberrypi* and *meta-digi-maker* Yocto layers under the
   Digi Embedded Yocto sources directory

        #> cd <DEY-INSTALLDIR>/sources
        #> git clone git://git.yoctoproject.org/meta-raspberrypi.git -b morty
        #> git clone https://github.com/digi-embedded/meta-digi-maker.git -b morty

    The following git revisions were validated by Digi:

      * meta-raspberrypi: 2a192261a914892019f4f428d7462bb3c585ebac


Create and build a project
--------------------------
We will use a ConnectCore 6UL SBC Express. This module has an expansion
connector that makes connecting Pi Hats possible.

1. Create a project for ConnectCore 6UL SBC Express

        #> mkdir <project-dir>
        #> cd <project-dir>
        #> . <DEY-INSTALLDIR>/mkproject.sh -p ccimx6ulstarter

2. Add *meta-raspberrypi* and *meta-digi-maker* layers to the project's
  *bblayers.conf* configuration file

        #> vi <project-dir>/conf/bblayers.conf

        <DEY-INSTALLDIR>/sources/meta-raspberrypi
        <DEY-INSTALLDIR>/sources/meta-digi-maker

3. Configure the project.

    Some Hats require extra configuration in the project's *local.conf*
    configuration file. See "Supported Raspberry Pi Hats".

4. Build the images

        #> bitbake core-image-base
        #> bitbake dey-image-aws


Supported Raspberry Pi Hats
---------------------------
Connect your Raspberry Pi Hat to the ConnectCore 6UL SBC Express using the
expansion connector. This is a 2-row 40-pins connector located on one side
of the board.

For more information about the expansion connector refer to the Hardware Reference Manual:

http://www.digi.com/resources/documentation/digidocs/pdfs/90001520.pdf

### Raspberry Pi Sense Hat

This add-on board has the following functionality:

  * 8x8 LED matrix display
  * Mini joystick
  * Sensors
    * Accelerometer
    * Barometric pressure
    * Gyroscope
    * Humidity
    * Magnetometer
    * Temperature

For more information about the Sense Hat board, refer to:

https://www.raspberrypi.org/products/sense-hat/

##### Enable Sense Hat support

To enable Raspberry Pi Sense Hat support for Digi Hardware, add

    RPI_SENSEHAT_ENABLED = "1"

to the project's configuration file and build the image.

This installs the Sense Hat Python library, and some examples under
*/opt/python-sense-hat/examples*.

For the full Sense Hat Python library API refer to: http://pythonhosted.org/sense-hat/api/


License
-------
Copyright 2017, Digi International Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
