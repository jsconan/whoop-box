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
# Generates the STL files for the tiny-whoops boxes.
#
# @author jsconan
#

# application params
preset=
whoopBoxHor=
whoopBoxVer=
whoopBoxDrw=

# script config
scriptpath=$(dirname $0)
project=$(pwd)
srcpath=${project}
dstpath=${project}/dist/stl
slcpath=${project}/dist/gcode
configpath=${srcpath}/config
partpath=${srcpath}/parts
allpresets=
format=
parallel=
cleanUp=
slice=
renderAngled=
renderWhoop=
renderAll=1

# include libs
source "${scriptpath}/lib/camelSCAD/scripts/utils.sh"

# Builds the destination path using the selected preset.
#
# @param name - The name of the set to render.
presetpath() {
    echo "${dstpath}$(prefixif "/" "$1")$(prefixif "/" "${preset}")"
}

# Builds the list of config parameters.
paramlist() {
    local params=(
        "$(varif "whoopBoxHor" ${whoopBoxHor})"
        "$(varif "whoopBoxVer" ${whoopBoxVer})"
        "$(varif "whoopBoxDrw" ${whoopBoxDrw})"
        "$(varif "preset" "${preset}" 1)"
    )
    echo "${params[@]}"
}

# Renders the files from a path.
#
# @param sourcepath - The path of the folder containing the SCAD files to render.
# @param destpath - The path to the output folder.
# @param prefix - Optional prefix added to the output file name
# @param suffix - Optional suffix added to the output file name
renderpath() {
    scadrenderall "$1" "$2" "$3" "$4" --quiet $(paramlist)
}

# Display the render config
#
# @param name - The name of the set to render.
showconfig() {
    local dest="$(presetpath "$1")"
    local input="${configpath}/setup.scad"
    local output="${dest}/setup.echo"
    local config="${dest}/config.txt"
    createpath "${dest}" "output"
    printmessage "${C_MSG}The box elements would be generated with respect to the following config:"
    scadecho "${input}" "${dest}" "" "" showConfig=1 $(paramlist) > /dev/null
    sed '1d; $d' "${output}" > "${config}"
    rm "${output}" > /dev/null
    cat "${config}"
}

# List the available presets
listpresets() {
    local input="${configpath}/setup.scad"
    local output="${dstpath}/setup.echo"
    createpath "${dstpath}" "output" > /dev/null
    scadecho "${input}" "${dstpath}" "" "" showPresets=1 $(paramlist) > /dev/null
    sed '1d; $d' "${output}"
    rm "${output}" > /dev/null
}

# Renders the selected preset
#
# @param name - The name of the set to render.
renderpreset() {
    local dest="$(presetpath "$1")"

    # make sure the destination path exists
    createpath ${dest}

    # show the config
    showconfig "$1"

    # render the files
    printmessage "${C_MSG}Rendering box elements"
    renderpath "${partpath}$(prefixif "/" "$1")" "${dest}"
}

# Renders the files with respect to the settings.
renderall() {
    if [ "${renderAngled}" != "" ]  || \
       [ "${renderWhoop}" != "" ] || \
       [ "${renderAll}" != "" ]; then
        printmessage "${C_MSG}Rendering boxes"
    else
        printmessage "${C_MSG}Nothing will be rendered"
    fi
    if [ "${renderAngled}" == "1" ] || [ "${renderAll}" == "1" ]; then
        printmessage "${C_MSG}- sets of angled boxes"
        renderpreset "angled"
    fi
    if [ "${renderWhoop}" == "1" ] || [ "${renderAll}" == "1" ]; then
        printmessage "${C_MSG}- all whoop boxes"
        renderpreset "whoop"
    fi
}

# load parameters
while (( "$#" )); do
    case $1 in
        "a"|"all")
            renderAll=1
        ;;
        "n"|"angled")
            renderAngled=1
            renderAll=
        ;;
        "w"|"whoop")
            renderWhoop=1
            renderAll=
        ;;
        "-p"|"--preset")
            preset=$2
            shift
        ;;
        "-a"|"--all")
            allpresets=1
        ;;
        "-l"|"--line")
            whoopBoxHor=$2
            shift
        ;;
        "-m"|"--column")
            whoopBoxVer=$2
            shift
        ;;
        "-d"|"--drawer")
            whoopBoxDrw=$2
            shift
        ;;
        "-f"|"--format")
            format=$2
            shift
        ;;
        "-p"|"--parallel")
            parallel=$2
            shift
        ;;
        "-s"|"--slice")
            slice=1
        ;;
        "-c"|"--clean")
            cleanUp=1
        ;;
        "-h"|"--help")
            echo -e "${C_INF}Renders OpenSCAD files${C_RST}"
            echo -e "  ${C_INF}Usage:${C_RST}"
            echo -e "${C_CTX}\t$0 [command] [-h|--help] [-o|--option value] files${C_RST}"
            echo
            echo -e "${C_MSG}  a,   all            ${C_RST}Render all elements (default)"
            echo -e "${C_MSG}  n,   angled         ${C_RST}Render the sets of angled boxes"
            echo -e "${C_MSG}  w,   whoop          ${C_RST}Render the sets of whoop boxes"
            echo -e "${C_MSG}  -h,  --help         ${C_RST}Show this help"
            echo -e "${C_MSG}  -p   --preset       ${C_RST}Set size preset to apply"
            echo -e "${C_MSG}  -a,  --all          ${C_RST}Render all presets"
            echo -e "${C_MSG}  -l,  --line         ${C_RST}Set the number of boxes per lines in the container"
            echo -e "${C_MSG}  -m   --column       ${C_RST}Set the nu,ber of boxes per columns in the container"
            echo -e "${C_MSG}  -d   --drawer       ${C_RST}Set the number of drawers in the cupboard"
            echo -e "${C_MSG}  -f   --format       ${C_RST}Set the output format"
            echo -e "${C_MSG}  -p   --parallel     ${C_RST}Set the number of parallel processes"
            echo -e "${C_MSG}  -s   --slice        ${C_RST}Slice the rendered files using the default configuration"
            echo -e "${C_MSG}  -c   --clean        ${C_RST}Clean up the output folder before rendering"
            echo
            exit 0
        ;;
        *)
            ls $1 >/dev/null 2>&1
            if [ "$?" == "0" ]; then
                srcpath=$1
            else
                printerror "Unknown parameter ${1}"
            fi
        ;;
    esac
    shift
done

# check OpenSCAD
scadcheck

# defines the output format
scadformat "${format}"

# defines the number of parallel processes
scadprocesses "${parallel}"

# clean up the output
if [ "${cleanUp}" != "" ]; then
    printmessage "${C_CTX}Cleaning up the output folder"
    rm -rf "${dstpath}"

    if [ "${slice}" != "" ]; then
        printmessage "${C_CTX}Cleaning up the slicer output folder"
        rm -rf "${slcpath}"
    fi
fi

# make sure the config exists
distfile "${configpath}/config.scad"
distfile "${configpath}/presets.scad"

if [ "${allpresets}" == "1" ]; then
    presets=($(listpresets))
    for p in "${presets[@]}"; do
        preset=$p
        renderall
    done
else
    renderall
fi

# run a post-render script
if [ -x "${scriptpath}/post-render.sh" ]; then
    printmessage "${C_CTX}Calling the post-render script"
    "${scriptpath}/post-render.sh"
fi

# slice the rendered files
if [ "${slice}" != "" ]; then
    printmessage "${C_CTX}Slicing the rendered files"
    ./slice.sh
fi
