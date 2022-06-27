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
# Initialize the project
#
# @author jsconan
#

# script config
scriptpath=$(dirname $0)
configpath=${scriptpath}/config

# make sure to get the library
if [ ! -d "${scriptpath}/lib/camelSCAD" ]; then
    if [ -d "${scriptpath}/.git" ] && [ -x "$(command -v git)" ]; then
        echo "Install camelSCAD using Git"
        git submodule init
        git submodule update
    else
        echo "Install camelSCAD from an archive"
        mkdir "${scriptpath}/lib"
        cd "${scriptpath}/lib"
        curl -LJO https://github.com/jsconan/camelSCAD/archive/refs/heads/main.zip
        unzip camelSCAD-main.zip
        rm camelSCAD-main.zip
        mv camelSCAD-main camelSCAD
    fi
fi

# include the libs
scriptpath=$(dirname $0)
configpath=${scriptpath}/config
source "${scriptpath}/lib/camelSCAD/scripts/utils.sh"

# make sure the config exists
distfile "${configpath}/config.ini"
distfile "${configpath}/config.scad"
distfile "${configpath}/presets.scad"
