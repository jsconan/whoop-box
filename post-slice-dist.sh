#!/bin/bash
#
# GPLv3 License
#
# Copyright (c) 2022 Jean-Sebastien CONAN
#
# This file is part of jsconan/whoop-box.
#
# jsconan/whoop-box is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# jsconan/whoop-box is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with jsconan/whoop-box. If not, see <http://www.gnu.org/licenses/>.
#

#
# A sample of post-processing script that can be called once the models have been sliced.
#
# To use it as a skeleton for your own script, please first run the following commands:
#    cp post-slice-dist.sh post-slice.sh
#    chmod +x post-slice.sh
#
# It will copy the sample to the file `post-slice.sh` and make sure it is executable.
# Then, you can modify the copy and add your own commands.
#
# @author jsconan
#

# Bootstrap the script
scriptpath=$(dirname $0)
source "${scriptpath}/lib/camelSCAD/scripts/utils.sh"

# Script config
project=$(pwd)
gcodepath="${project}/dist/gcode/"
sdcardpath="/PATH/TO/SD/CARD"   # <-- CHANGE THIS!
logpath="${project}/dist/gcode-sync.log"

# Post process the sliced files
printmessage "${C_MSG}==========================================="
printmessage "${C_MSG}Post-slice script: copy Gcode to the SDcard"
date > ${logpath}
createpath "${sdcardpath}"
rsync -ahvt --no-links --delete --partial --force --modify-window=1 --exclude=.DS_Store --log-file=${logpath} "${gcodepath}" "${sdcardpath}"
printmessage "${C_MSG}==========================================="
