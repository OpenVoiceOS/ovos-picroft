#!/usr/bin/sh

echo "updating ovos"
sh ./update_ovos.sh
echo "done with ovos update"

echo "updating phal"
sh ./update_phal.sh
echo "done with phal update"

echo "updating ocp"
sh ./update_ocp.sh
echo "done with ocp update"

echo "updating skills"
sh ./update_skills.sh
echo "done with skills update"
