#!/bin/bash



function update_ggwave () {
    python_version=`python --version`
    if [[ $python_version =~ ".11" ]]; then
    echo "https://whl.smartgic.io/ggwave-0.4.2-cp311-cp311-linux_aarch64.whl" >> requirements.txt
    fi
    }

function create_requirements () {
    if [[ -f requirements.txt ]]; then
    rm requirements.txt
    fi

    OVOS_PACKAGES=$(pip list | grep -i ovos)

    for w in ${OVOS_PACKAGES[@]}; do
        if [[ $w =~ [0-9] ]]; then
        continue
    else
    echo "updating $w"
    if [[ "$w" =~ "ggwave" ]]; then
    update_ggwave
    fi
    if [[ "$w" =~ "skill-ovos-ip" ]]; then
        echo "ovos-skill-ip" >> requirements.txt
    else
        echo "$w" >> requirements.txt
    fi
}

function install () {
    case $1 in
    --alpha)
        pip install -r requirements.txt -U --pre
        ;;
    *)
        pip install -r requirements.txt -U
        ;;
    esac

    rm requirements.txt
    }

clear

if [[ ! ${VIRTUAL_ENV} ]]; then
echo "You must be in your venv for this script to work."
echo "Please activate it and run this script again"
exit 1
fi

echo "This script will update the OVOS packages installed on this device."
echo
read -p "Would you like to continue? Y/n  " response
if [[ "$response" =~ ^[Yy] ]]; then
create_requirements
else
echo "Installation aborted by the user."
exit 1
fi
echo
echo "Would you like to update to the latest Alpha packages?"
read -p "WARNING: These are not stable packages and change on a regular basis.  Y/n  " alpha_response
if [[ "$alpha_response" =~ ^[Yy] ]]; then
install --alpha
else
install
fi

echo
echo "All OVOS packages have been updated."
echo "Restart OVOS for the changes to take effect"
