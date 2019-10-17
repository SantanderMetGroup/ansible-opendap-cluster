#!/bin/bash
git clone --recursive -b devel https://github.com/SantanderMetGroup/ansible-thredds-cluster
cd ansible-thredds-cluster/scenarios/zequi/tools
virtualenv virtualenv
source virtualenv/bin/activate
pip install --upgrade pip setuptools
pip install ansible==2.5.*
./run.sh -r ~/tds deploy
