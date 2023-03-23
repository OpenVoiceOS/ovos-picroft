# update pip
pip install -U pip

# service hooks needs sdnotify
pip install sdnotify==0.3.2

# non ovos packages
pip install tornado==6.2
pip install adapt-parser==1.0.0
pip install padacioso==0.1.2
pip install PyYAML==5.4.1
pip install padatious==0.4.8
pip install fann2==1.0.7
pip install PyAudio~=0.2
pip install SpeechRecognition>=3.8.1
pip install --no-deps quiet.py

# install ovos-core
pip install ovos-core==0.0.7
pip install ovos_PHAL==0.0.4
pip install ovos_plugin_common_play==0.0.4
pip install git+https://github.com/OpenVoiceOS/ovos-cli-client
pip install ovos-bus-client
# Does not currently work correctly
# pip install git+https://github.com/OpenVoiceOS/OVOS-Dashboard.git
pip install ovos-vad-plugin-webrtcvad==0.0.1

# install phal plugins
pip install ovos-phal-plugin-connectivity-events==0.0.2
pip install ovos-phal-plugin-system==0.0.3
pip install ovos-PHAL-plugin-ipgeo==0.0.1
pip install ovos-PHAL-plugin-oauth==0.0.1
# not sure how the ovos-dashboard works with pip installed skills, so wont install this yet
# pip install ovos-phal-plugin-dashboard==0.0.1
pip install ovos-phal-plugin-alsa==0.0.2
pip install ovos-phal-plugin-pulseaudio==0.0.2
pip install git+https://github.com/OpenVoiceOS/ovos-PHAL-plugin-balena-wifi
pip install ovos-PHAL-plugin-wifi-setup==1.1.0

# install ww plugins
pip install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-precise-lite
pip install ovos-ww-plugin-pocketsphinx==0.1.3
pip install ovos-ww-plugin-vosk==0.0.1

# install stt plugins
pip install ovos-stt-plugin-selene==0.0.3
pip install ovos-stt-plugin-vosk==0.1.4
pip install ovos-stt-plugin-server==0.0.2

# install tts plugins
pip install ovos-tts-plugin-mimic==0.2.7.post1
pip install ovos-tts-plugin-mimic2==0.1.5
pip install ovos-tts-plugin-mimic3-server==0.0.1
pip install ovos-tts-plugin-google-tx==0.0.3
pip install ovos-tts-plugin-server==0.0.2a1

# install ocp extentions
pip install ovos-ocp-youtube-plugin==0.0.1
pip install ovos-ocp-m3u-plugin==0.0.1
pip install ovos-ocp-rss-plugin==0.0.2
pip install ovos-ocp-files-plugin==0.13.0
pip install ovos-ocp-news-plugin==0.0.3
