python -m venv /home/ovos/.venv

source /home/ovos/.venv/bin/activate

pip3 install -U pip
pip3 install wheel

git clone https://github.com/OpenVoiceOS/ovos-docs-viewer
mv ovos-docs-viewer/ovos_docs_viewer/ovos_docs.py /home/ovos/.local/bin/ovos_docs.py
rm -rf ovos-docs-viewer

pip3 install textual

deactivate
