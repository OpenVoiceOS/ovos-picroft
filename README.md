# raspbian-ovos

<strong>** DEV BRANCH **</strong>

<strong>Images built from this branch are NOT guaranteed to always work.</strong>

Run OVOS on top of RaspberryPiOS

Pre-built images can be found on the [OpenVoiceOS Downloads Page](https://ovosimages.ziggyai.online/raspbian/).

Check out the [community documentation](https://openvoiceos.github.io/community-docs/install_raspbian/) for information on how to install manually or build an image yourself.

Purpose of this guide


This guide was originally designed for a headless, (No GUI) Raspberry Pi 3. The RPi3 does not have the umph required to reliably run ovos-shell, hence "headless". There is not an image available at this point in time that works with this hardware(RPi3), so this was constructed. This guide DOES NOT produce the same experience as the official images do. This just creates a minimal install, that the user can then expand to their own personal needs.

Please, if any mistakes, including spelling mistakes are found, or if a more detailed explanation of a step is needed, open an issue here and I will address it ASAP.

## Shairport

Shairport-sync is available for this device as `raspOvos`

#### Playback issues

It has been noted that there is no audio playback with certain output devices due to sampling rates...but there is a fix

- ssh into your device
- `shairport-sync -h`
  - at the end of the output will be the devices that are available.  make note of the name of the device you want to use
- `sudo nano /etc/shairport-sync.conf`
  - find the line that contains `output_device = "default"`
  - change to read `output_device = "plughw:<device_name_from_above>"
  - save the file
- `sudo systemctl restart shairport-sync.service`

Playback should now work

## Raspotify

This loads and the you can see the device in the `available devices` on the spotify app, but a premium account is needed to connect to it.  As of this writing, I do not have a premium account to test with.  Any feedback would be great.

## ISSUES

All issues and/or feedback is more than welcome.

File them on the [raspbian-ovos issues page](https://github.com/OpenVoiceOS/raspbian-ovos/issues)
