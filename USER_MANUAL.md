# Welcome to OpenVoiceOS and your new raspOVOS device  
[OpenVoiceOS.org](https://OpenVoiceOS.org)  
\
raspOVOS is a complete, customizable, and open source voice assistant developed to run on a Raspberry Pi.  (Tested with 3b/4/5)  
\
**Github links:**  
[OpenVoiceOS](https://github.com/OpenVoiceOS)  
[raspOVOS](https://github.com/OpenVoiceOS/raspOVOS)  
\
**Matrix chat room**  
[OVOS support](https://matrix.to/#/#OpenVoiceOS-Support:matrix.org)

---
## What is OVOS and raspOVOS

OVOS (OpenVoiceOS) is a collection of Python packages when put together create an AWESOME, privicay oriented voice assistant capable of running totally on device or a local LAN. [^1]  

raspOVOS is a modified image of [raspberry pi OS](https://www.raspberrypi.com/software/) containing the OVOS software stack.  

raspOVOS is special because of some special software which allows auto-detection and configuration of several devices including USB microphones, reSpeaker microphone HAT's and others. [^2]  

---
### First boot with your raspOVOS device

Depending on the version of Pi that is used, determines how fast the first boot will take.  A Pi3b will take SEVERAL minutes to perform the first boot.  
\
If you have a screen attached, you can view the boot process happening.
\
The first boot will finish the install process by resizing your disk and enabling all of the OVOS services.  
\
**NOTE** This is a headless device and you will be prompted with a voice on how to proceed with your first setup.  
\
After a few minutes, depending on your device, you will here a voice prompt on how to setup your WiFi.  LAN connections will skip this step.  
\
Expect a prompt such as this.  
> "I have created a temporary WiFi network called OVOS. Connect to it from your phone or computer and go to OpenVoiceOS.com.  Choose the Wifi network from the list you would like to connect your device to."

\
After that, your device will continue to setup OVOS and the skills which require internet access. [^3]  
\
You should now have a working voice assistant!!

---
## What is next?  

Your voice assistant should be complete now, but you can do so much more.  

### Access your voice assistant

raspOVOS comes with a ssh server already enabled so you should be able to access your assistant from any computer connected to the same LAN.  
\
Open a terminal and enter the following command.  
`ssh ovos@raspovos`  
It will then ask for the password.  
`ovos` [^4]  
\
Upon logging in, some nice ASCII art (courtisy of [Goldyfruit](https://github.com/goldyfruit)) will be shown, with some command line tools that are included with raspOVOS.

---

#### Command line tools

**[ovos-config](https://github.com/OpenVoiceOS/ovos-config)**  
\
A small helper tool is included to quickly show, get or set config values  
\
Quick rundown (cli):

- `ovos-config get`
- Loose search (search a key or parts therof)  

\
Given an entry of

        {'PHAL': {
                'ovos-PHAL-plugin-system': {
                        'enabled': True
                },
                'ovos-PHAL-plugin-connectivity-events': {
                        'enabled': True
                },
                ... 
        }

    `ovos-config get -k phal` would yield  **all**  PHAL entries and present it to the user (and the path where they were found)


  * Strict search (search keys in a distinct location): 

    `ovos-config get -k /PHAL/ovos-PHAL-plugin-system/enabled` 

    This will output only the value or exit out if no key is found (root slash indicating a strict search)

* `ovos-config set` 

  * Searches loosely for keys containing the query string and presents a choice to the user to define a value

    `ovos-config set -k phal`
    

    The type is derived from the joined config and thus can be safely cast into the user conf.\
    Optionally a value (`-v`) can be sent as an argument.

* `ovos-config show` 

  * Get a full table of either the joined, user (`-u`), system (`-s`) or remote (`-r`) configuration.  
    This can be further refined by passing a `--section`, which can be listed with `ovos-config show -l`


**ovos-listen**  
\
`ovos-listen` activates the microphone without using a wakeword. eg "Hey Mycroft"
\
Enter `ovos-listen` into the terminal and ask a question with your voice.
\
**ovos-speak**  
\
`ovos-speak <phrase>` Have your OVOS device say what you type.  
\
**ovos-say-to**  
\
`ovos-say-to <phrase>`  Send an utterance, command, to your OVOS device as if it was spoken.  
\
### View the documentation
\
**ovos-docs-viewer**  
\
`ovos-docs-viewer <community/technical/hivemind/messages>`  
\
You can view the OVOS documentation in your terminal.  
\
### Debugging
\
OVOS provides a helper script to view the logs produced during operation of your device.  
[ovos-logs](https://github.com/OpenVoiceOS/ovos-utils/blob/dev/ovos_utils/log_parser.py) can help navigate the logs.  For usage see the [ovos-util](https://github.com/OpenVoiceOS/ovos-utils/blob/dev/README.md) README.md  
\
raspOVOS also includes a script to allow real time viewing of the logs.  
type `ologs` into a terminal and the logs will show up.  `<ctl>-C` to exit.

By default, OVOS will only show the logs marked as `INFO`.  This saves on precious disk space and does not have as much information shown.  
\
This can be changed through the config file.  
\
### Advanced configuration
\
The user configuration file is found at `~/.config/mycroft/mycroft.conf`  
This is a standard JSON file and can be checked with the command `cat ~/.config/mycroft/mycroft.conf | jq`
\
### Skills
\
Skills should be PIP installable and should be placed in the raspOVOS venv located at `~/.venv`.  The venv is automatically activated when you log in with a shell.  
\
Example:  
`pip install ovos-skill-moviemaster`

---

[^1] Pi4/5 for complete on device use.  
[^2] A complete list is available in the [ovos-i2csound](https://github.com/OpenVoiceOS/ovos-i2csound) and the [ovos-i2c-detection](https://github.com/OpenVoiceOS/ovos-i2c-detection) repositories on GitHub.  
[^3] All skills are optional, but some require an internet connection to work, weather forecasts for one.  And even the date/time because of the lack of a persistent clock on a Raspberry Pi.  
[^4] The default user:password is `ovos:ovos`.  It is suggested that you change the password for security reasons.  The `ovos` user has root privileges and can change your complete filesystem without being prompted for a password.  
