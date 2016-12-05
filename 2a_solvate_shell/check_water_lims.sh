#!/bin/bash

awk '{if($5==9999) print($11)}' water_shell.pdb
