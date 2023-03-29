#!/bin/bash -e

set -exu

pip install -U pip
pip install -U wheel

pip install -r files/system.txt

