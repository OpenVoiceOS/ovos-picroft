#!/bin/bash -e

set -exu

on_chroot <<EOF

chown -Rv "$FIRST_USER_NAME":"$FIRST_USER_NAME" "/home/$FIRST_USER_NAME"
chmod -Rv +x "/home/$FIRST_USER_NAME/.local/bin/"

EOF
