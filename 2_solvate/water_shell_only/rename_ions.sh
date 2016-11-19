#!/bin/bash

awk '{ gsub(/ NA /, " SOD"); print }' water_shell.pdb > tmp && mv tmp water_shell.pdb
awk '{ gsub(/INA/, "SOD"); print }' water_shell.pdb > tmp && mv tmp water_shell.pdb
awk '{ gsub(/ICL/, "CLA"); print }' water_shell.pdb > tmp && mv tmp water_shell.pdb
awk '{ gsub(/ CL /, " CLA"); print }' water_shell.pdb > tmp && mv tmp water_shell.pdb


