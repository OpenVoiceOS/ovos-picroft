#!/bin/bash
# echo -e "\e[31m"
# echo "            ___                __     __    _           ___  ____  "
# echo "           / _ \ _ __   ___ _ _\ \   / /__ (_) ___ ___ / _ \/ ___| "
# echo "          | | | | '_ \ / _ \ '_ \ \ / / _ \| |/ __/ _ \ | | \___ \ "
# echo "          | |_| | |_) |  __/ | | \ V / (_) | | (_|  __/ |_| |___) |"
# echo "           \___/| .__/ \___|_| |_|\_/ \___/|_|\___\___|\___/|____/ "
# echo "                |_|                                                "
# echo
# echo -e "\e[0m"
echo "\t\t\t\t\033[1m================================\033[0m"
echo "\t\t\t\t --- Welcome to OpenVoiceOS ---\033[0m"
echo "\t\t\t\t    raspOVOS  Edition v0.0.1\033[0m"
echo "\t\t\t\t\033[1m================================\033[0m"
echo ""
echo ""
echo "OVOS Tool COMMANDs:"
echo "  ovos-config            Manage your local OVOS configuration files"
echo "  ovos-listen            Activate the microphone to listen for a command"
echo "  ovos-speak  <phrase>   Have OVOS speak a phrase to the user"
echo "  ovos-say-to <phrase>   Send an utterance to OVOS as if spoken by a user"
echo
echo "OVOS Skill Manager COMMANDs:"
echo "  osm install <skill|url>   Install mycroft skills"
echo "  osm remove  <skill|url>   Uninstall mycroft skills"
echo "  osm update                Update installed skills"
echo
echo "OVOS Docs COMMANDs:"
echo "  ovos-docs-viewer community          View the OVOS Community docs in the terminal"
echo "  ovos-docs-viewer techincal          View the OVOS Technical docs in the terminal"
echo "  ovos-docs-viewer hivemind           View the HiveMind docs in the terminal"
echo "  ovos-docs-viewer messages           View OVOS Message specs in the terminal"
echo
echo "Misc Helpful COMMANDs:"
echo "  ovos-simple-cli         Chat with your device through the terminal"
echo

