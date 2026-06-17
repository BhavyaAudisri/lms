#!/bin/bash
growpart /dev/xvda 4
pvresize /dev/xvda4
lvextend -L +10G /dev/RootVG/varVol