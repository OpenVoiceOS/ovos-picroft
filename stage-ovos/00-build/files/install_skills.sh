# install skills

# from ovos
pip install ovos-skill-date-time==0.2.2
pip install ovos-skill-naptime==0.2.2
pip install ovos-skill-personal==0.0.3
pip install ovos-skill-volume==0.0.1
pip install ovos-skill-stop==0.2.1
pip install ovos-skill-hello-world==0.0.3

# from NeonGeckoCom
pip install git+https://github.com/NeonGeckoCom/skill-user_settings
pip install git+https://github.com/NeonGeckoCom/skill-spelling
# wont install this untill I figure out how to not auto download sample music
# pip install git+https://github.com/NeonGeckoCom/skill-local_music
pip install git+https://github.com/NeonGeckoCom/skill-caffeinewiz

# ovos fallbacks
pip install ovos-skill-fallback-unknown==0.0.2
# New commit not working yet with chatgpt
pip install git+https://github.com/OpenVoiceOS/skill-ovos-fallback-chatgpt@eab33b97f6209afbd5a5d1fcd8c2ac9390d012ca

# from ovos git
pip install git+https://github.com/OpenVoiceOS/skill-alerts
pip install git+https://github.com/OpenVoiceOS/skill-ovos-weather
pip install git+https://github.com/OpenVoiceOS/skill-ovos-ddg
pip install git+https://github.com/OpenVoiceOS/skill-ovos-wolfie
# The wiki skill seems to be causing issues at the moment
# pip install git+https://github.com/OpenVoiceOS/skill-ovos-wikipedia
pip install git+https://github.com/OpenVoiceOS/skill-ovos-news
pip install git+https://github.com/OpenVoiceOS/skill-ovos-somafm
pip install git+https://github.com/OpenVoiceOS/skill-ovos-youtube-music

# non pip skills
mkdir -p /home/ovos/.local/share/mycroft/skills
cd /home/ovos/.local/share/mycroft/skills

git clone https://github.com/JarbasSkills/skill-icanhazdadjokes.git skill-icanhazdadjokes.jarbasskills
pip install -r skill-icanhazdadjokes.jarbasskills/requirements.txt

# Would like to have this, HEHE, but not working right now
# git clone https://github.com/JarbasSkills/skill-pickup-lines.git skill-pickup-lines.jarbasskills
# pip install -r skill-pickup-lines.jarbasskills/requirements.txt

# Both of these have issues at the moment also
# git clone https://github.com/JarbasSkills/skill-quote-of-day.git skill-quote-of-day.jarbasskills
# pip install -r skill-quote-of-day.jarbasskills/requirements.txt
#
# git clone https://github.com/JarbasSkills/skill-stephen-hawking.git skill-stephen-hawking.jarbasskills
# pip install -r skill-stephen-hawking.jarbasskills/requirements.txt

git clone https://github.com/JarbasSkills/skill-confucius-quotes.git skill-confucius-quotes.jarbasskills
pip install -r skill-confucius-quotes.jarbasskills/requirements.txt

git clone https://github.com/andlo/fairytalez-skill.git fairytalez-skill.andlo
pip install -r fairytalez-skill.andlo/requirements.txt

# This would be neat to have also, just not yet I guess
# git clone https://github.com/andlo/sound-tuner-skill.git sound-tuner-skill.andlo
# pip install -r sound-tuner-skill.andlo

git clone https://github.com/forslund/skill-cocktail.git skill-cocktail.forslund
pip install -r skill-cocktail.forslund/requirements.txt

cd /home/ovos
