python -m venv /home/ovos/.venv

source /home/ovos/.venv/bin/activate

pip3 install -U pip
pip3 install wheel textual

pip3 install git+https://github.com/OpenVoiceOS/ovos-docs-viewer

deactivate
