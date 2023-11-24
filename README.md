# raspbian-ovos

<strong>** DEV BRANCH **</strong>

<strong>Images built from this branch are NOT guaranteed to always work.</strong>

Run OVOS on top of RaspberryPiOS

Pre-built images can be found on the [OpenVoiceOS Downloads Page](https://ovosimages.ziggyai.online/raspbian/development).

Check out the [community documentation](https://openvoiceos.github.io/community-docs/qs_intro/) for quick start guide on installing an image.

This guide was originally designed for a headless, (No GUI) Raspberry Pi 3. The RPi3 does not have the umph required to reliably run ovos-shell, hence "headless". There is not an image available at this point in time that works with this hardware(RPi3), so this was constructed. This guide DOES NOT produce the same experience as the official images do. This just creates a minimal install, that the user can then expand to their own personal needs.

Please, if any mistakes, including spelling mistakes are found, or if a more detailed explanation of a step is needed, open an issue here and I will address it ASAP.

## Features

Built on the official rasbianOS lite image (latest is bookworm).

Multiple image variants can be built with the files in this repository.  This includes "headless", "GUI", "Mark 2", "Mark 1", and any other custom image you would like to build.

### Auto Hardware Detection

**WIP (Feedback Welcome)**

#### Supported devices

- USB Devices
  - PS3 Eye
  - BlueSnowball
  - Generic WebCam
  - Possibly more, but not tested
- Seed voicecard
  - 2 mic
  - 4 mic
  - 6 mic
  - 8 mic
- SJ201
  - Daughter card for the Mark 2
- Google AIY-VoiceBonnet V2

### KDEConnect

Available with the GUI images

### Shairport

**WIP not yet implemented**

Shairport-sync is available for this device as `raspOvos`

### Raspotify

**WIP not yet implemented**

### ISSUES

All issues and/or feedback is more than welcome.

File them on the [raspbian-ovos issues page](https://github.com/OpenVoiceOS/raspbian-ovos/issues)
