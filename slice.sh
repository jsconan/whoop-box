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
# Generates the STL files for the tiny-whoops boxes.
#
# @author jsconan
#

# script config
scriptpath=$(dirname $0)
configpath="config/config.ini"

# include libs
source "${scriptpath}/../lib/camelSCAD/scripts/utils.sh"

# defines the config path
distfile "${configpath}"

# redirect to the lib utils
"$(dirname $0)/../lib/camelSCAD/scripts/slice.sh" \
    --input "dist/stl" \
    --output "dist/gcode" \
    --config "${configpath}" \
    --prusaslicer \
    --recurse \
    "$@"
