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
# A sample of post-processing script that can be called once the models have been rendered.
#
# To use it as a skeleton for your own script, please first run the following commands:
#    cp post-render-dist.sh post-render.sh
#    chmod +x post-render.sh
#
# It will copy the sample to the file `post-render.sh` and make sure it is executable.
# Then, you can modify the copy and add your own commands.
#
# @author jsconan
#

# Bootstrap the script
scriptpath=$(dirname $0)
source "${scriptpath}/lib/camelSCAD/scripts/utils.sh"

# Do something... Some helpers have been loaded from the utils
printmessage "${C_MSG}==============================="
printmessage "${C_MSG}This is the post render script!"
printmessage "${C_MSG}==============================="
