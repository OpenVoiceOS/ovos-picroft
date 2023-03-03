#!/usr/bin/sh

echo "updating ovos"
/home/ovos/.local/bin/update_ovos.sh
echo "done with ovos update"
echo
echo "updating phal"
/home/ovos/.local/bin/update_phal.sh
echo "done with phal update"
echo
echo "updating ocp"
/home/ovos/.local/bin/update_ocp.sh
echo "done with ocp update"
echo
echo "updating skills"
/home/ovos/.local/bin/update_skills.sh
echo "done with skills update"
echo
echo "updating extras"
/home/ovos/.local/bin/update_extras.sh
echo "done updating extras"
echo
echo "done with all updates"
