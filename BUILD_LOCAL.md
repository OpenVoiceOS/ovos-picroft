# Build raspOVOS locally

It is possible to build this image locally for development purposes or for fun.

## Understanding this repository

This repository contains several directories with the `stage-` prefix.  Each one is executed in the order specified in a config file. [example here](#)

A few of the stages are needed for an OVOS image.  Once a `headless` image is built, other stages can be added for other usage such as a GUI system, or Mark2 device.

## Needed for Headless Image

### stage-prep

This is where all of the system setup happens.

- Adds an apt repository for `mimic`
- Configures locale
- Installs essential packages with apt
- Patches `cmdline.txt` for zram
- Sets up automounting of USB media
- Adds `system` and `user` systemd preset files
- Disables WiFi powersave
- Sets up rules for NetworkManager
- Creates `.bashrc`, `.bash_profile`, and other `.<filename>` files in the users home directory

### stage-splash

**Optional**

Add a little pizazz and give it a splash screen

### stage-core

This is where [ovos-core](https://github.com/OpenVoiceOS/ovos-core) and [ovos-messagebus](https://github.com/OpenVoiceOS/ovos-messagebus) are installed.

This also creates the `ovos.service`, `ovos-skills.service` and `ovos-messagebus.service`

### stage-hivemind

**Optional**

This is here so you can make your device a [HiveMind listener](https://github.com/JarbasHiveMind/HiveMind-core).

The service `hivemind-listener.service` is created, but disabled by default.

On a running image, issue the command `systemctl --user enable hivemind-listener.service` and `systemctl --user start hivemind-listener.service` to start it automatically on boot.

### stage-skills

Duh!! Install the skills here.  The service was created in `stage-core`, but skills are installed here.  This is just a MINIMAL set of skills to get your OVOS assistant up and running.  More can be installed on a running system.

**At this point, with `hivemind-listener.service` enabled, you can skip to the last step, [stage-finalize](#), and have a working HiveMind master**

### stage-audio

This stage is where pulseaudio, or eventually pipewire is installed and configured.

There is a `hardware` section here that has a service for autodetection of HAT's, including `respeakers` and the `sj201` *(implemented later)*.  This section is a **WIP** and any feedback would be great.

### stage-speech

[ovos-audio](https://github.com/OpenVoiceOS/ovos-audio) is installed and configured.

TTS engines are installed and configured.

### stage-listener

This is where [ovos-dinkum-listener](https://github.com/OpenVoiceOS/ovos-dinkum-listener) is installed and configured.

You can also configure your microphone and VAD plugins here.

### stage-ggwave

**Optional**

This is installed after `stage-audio` because it depends on sound to work.

For more informaton on how to use the [ovos-audio-transformer-plugin-ggwave](https://github.com/OpenVoiceOS/ovos-audio-transformer-plugin-ggwave).

### stage-phal

[ovos_PHAL](https://github.com/OpenVoiceOS/ovos-PHAL) (Plugin based Hardware Abstraction Layer) is where OVOS interacts with the device hardware.

**From here you can skip to [stage-finalize](stage-finalize) and have a complete `raspOVOS headless` system which will even run on a RPi3b**

## Optional and a WIP for now

### stage-shareport

Apple AirPlay support

### stage-spotify

Premium Spotify support

## Needed for GUI Image

### stage-gui

This stage adds all of the components to have a working OVOS GUI device.  **You must have at least a RPi4 2G for this to run**

[ovos-shell](#) and [ovos-gui](#) are installed and configured here.

The `/boot/firmware/config.txt` is modified to allow a GUI

**Skip to [stage-finalize](stage-finalize) to build a simple raspOVOS-GUI image**

## Optional Special Stages

### stage-mark1

**WIP**

Special configuration to support the Mycroft Mark1 device

### stage-mark2

**WIP**

Special configuration to support the Mycroft Mark2 device

## And the Final Stage

### stage-finalize

This is where the final things happen.

- system links to log files
- enabling systemd service files
- naming the image

# Pi-gen

In order to build an image, we use the official image builder of raspbianOS...[pi-gen](https://github.com/RPi-Distro/pi-gen).

pi-gen is organized into branches depending on the version you would like to build.

- master
  - The default branch - 32b `bookworm`
- arm64
  - The branch we normally use - 64b `bookworm`
- bullseye
  - 32b `bullseye`
- bullseye-arm64
  - 64b `bullseye`

For specific information on using pi-gen, consult the [README](https://github.com/RPi-Distro/pi-gen/blob/master/README.md)file.

# Building an Image

From this point, we will assume you are working from your `home` directory

`cd ~`

Clone the required repositories

`git clone https://github.com/OpenVoiceOS/raspbian-ovos`

`git clone https://github.com/RPi-Distro/pi-gen`

Copy the `raspbian-ovos-config.example` file to make the required changes to it.

`cp raspbian-ovos/raspbian-ovos-config.example ./raspbian-ovos-config`

Edit the file

`nano ./raspbian-ovos-config`

Change all references to `<FULL/PATH/TO/CLONED/REPO>` to where you cloned the `raspbian-ovos` repository.  For this example it would be `/home/<USER>/raspbian-ovos/`

The example file is configured for a headless image.  Add the stages from above for a GUI or other image.

You can also change the name of the image and other configuration settings, such as the default locale.

After making your changes, save and exit

`Ctl-o`

`Ctl-x`

Move into the pi-gen directory.

`cd pi-gen`

Switch to the `arm64` branch of `pi-gen`

`git checkout arm64`

To actually build an image, you need root privileges.

#### Start the build process

`sudo ./build.sh -c /home/<USER>/raspbian-ovos-config`

The `-c` flag should point to your edited configuration file.

Sit back and wait.  The build process can last several hours.

#### Getting the image

After the build process, a compressed image will be avaliable in the directory `~/pi-gen/deploy`

Write the image to a USB3 drive or a SSD drive.  SD cards may work, but have not been tested.

Boot your new OVOS assistant and enjoy!!
