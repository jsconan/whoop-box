#!/bin/bash
#
# GPLv3 License
#
# Copyright (c) 2019-2022 Jean-Sebastien CONAN
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
# Generates the pictures for the documentation of the project.
#
# @author jsconan
#

# script config
scriptpath="$(dirname $0)"
project="$(pwd)"
srcpath="${project}/pictures"
dstpath="${project}/dist/pictures"
tmppath="${project}/tmp"
configpath="${project}/config"

# include libs
source "${scriptpath}/lib/camelSCAD/scripts/utils.sh"

# options
mask="*.${scadext}"
imgext="png"
vidext="gif"
framerate=15
imgstep=3
imgwidth=320
imgheight=240
theme="Starnight"

# prepate the output folder
createpath "${dstpath}" "output"
createpath "${tmppath}" "tmp"

# make sure the config exists
distfile "${configpath}/config.scad"
distfile "${configpath}/presets.scad"

# list the pictures to render
printmessage "Processing rendering from ${C_SEL}${srcpath}${C_RST}..."
foldermustcontain "${srcpath}" "${mask}" "render"
list=($(find "${srcpath}" -maxdepth 1 -name "${mask}"))

for filename in "${list[@]}"; do
    name=$(basename "${filename%.*}" )
    showsteps="${tmppath}/${name}.${echoext}"
    picture=

    # get the number of steps
    scadecho "${filename}" "${tmppath}" "" "" showSteps=1 > /dev/null
    step=$(sed 's/[^0-9]*//g' "${showsteps}")

    if [ "$step" != "" ]; then
        picture="${dstpath}/${name}.${vidext}"

        # compute the number of images to render
        length=$((${step} * ${imgstep}))

        # generate each image of the amimation
        printmessage "${C_RST}Will render ${C_SEL}${length}${C_RST} frames from ${C_SEL}${filename}${C_RST}"
        scadpreview "${filename}" "${tmppath}" "${imgext}" "" "" --quiet --animate ${length} --projection p --colorscheme "${theme}" --imgsize ${imgwidth},${imgheight}

        # produce the video
        printmessage "${C_RST}Will render a video of ${C_SEL}${length}${C_RST} frames with a rate of ${C_SEL}${framerate}${C_RST} images per seconds"
        ffmpeg -framerate ${framerate} -i "${tmppath}/${name}%5d.${imgext}" "${picture}" -y

        # clean up the place
        rm "${tmppath}/${name}"*."${imgext}" 2> /dev/null
        rm "${showsteps}" 2> /dev/null
    else
        picture="${dstpath}/${name}.${imgext}"

        # generate a single image
        printmessage "${C_RST}Will render a picture from ${C_SEL}${filename}${C_RST}"
        scadpreview "${filename}" "${dstpath}" "${imgext}" "" "" --quiet --projection p --colorscheme "${theme}" --imgsize ${imgwidth},${imgheight}
    fi

    if [ -f "${picture}" ]; then
        printmessage "${C_RST}Picture rendered at ${C_SEL}${picture}${C_RST}"
    fi
done

