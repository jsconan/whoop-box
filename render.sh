#!/bin/bash
#
# GPLv3 License
#
# Copyright (c) 2019 Jean-Sebastien CONAN
#
# This file is part of jsconan/things.
#
# jsconan/things is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# jsconan/things is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with jsconan/things. If not, see <http://www.gnu.org/licenses/>.
#

#
# Generates the STL files for the tiny-whoops boxes.
#
# @author jsconan
#

# application params
whoop="tiny65bl"
boxX=
boxY=
drawerX=
drawerY=
drawers=
whoopCountBox=
whoopCountDrawer=
drawerCountCupboard=

# script params
output="output"
fileext=".scad"

# script config
scriptPath=$(dirname $0)
project=$(pwd)
dstpath=${project}/${output}
src=${project}/*${fileext}

# color codes
C_ERR="\033[31m"
C_SEL="\033[32m"
C_SPE="\033[33m"
C_CTX="\033[36m"
C_RST="\033[0m"
C_MSG="\033[1m"
C_INF="\033[32m"

# renders a file
# @param fileName
render() {
    dst="${dstpath}/${whoop}-$(basename $1 ${fileext}).stl"
    echo -e "${C_RST}Rendering of ${C_SEL}$(basename $1)${C_RST} to ${C_SEL}${dst}"
    openscad --render -o "${dst}" "$1" \
        -D "renderMode=\"prod\"" \
        -D "whoopType=\"${whoop}\"" \
        -D "${whoopCountBox}" \
        -D "${whoopCountDrawer}" \
        -D "${drawerCountCupboard}"
}

echo -e "${C_RST}"

# load parameters
while (( "$#" )); do
    case $1 in
        "-t"|"--whoop")
            whoop=$2
            shift
        ;;
        "-x")
            boxX=$2
            drawerX=$2
            shift
        ;;
        "-y")
            boxY=$2
            drawerY=$2
            shift
        ;;
        "-b"|"--box")
            boxX=$2
            boxY=$2
            shift
        ;;
        "-bx"|"--boxX")
            boxX=$2
            shift
        ;;
        "-by"|"--boxY")
            boxY=$2
            shift
        ;;
        "-d"|"--drawer")
            drawerX=$2
            drawerY=$2
            shift
        ;;
        "-dx"|"--drawerX")
            drawerX=$2
            shift
        ;;
        "-dy"|"--drawerY")
            drawerY=$2
            shift
        ;;
        "-ds"|"--drawers")
            drawers=$2
            shift
        ;;
        "-h"|"--help")
            echo -e "${C_INF}Renders OpenSCAD files${C_RST}"
            echo -e "  ${C_INF}Usage:${C_RST}"
            echo -e "${C_CTX}\t$0 [-h|--help] [-o|--option value] files${C_RST}"
            echo
            echo -e "${C_MSG}  -h,  --help         ${C_RST}Show this help"
            echo -e "${C_MSG}  -t,  --whoop        ${C_RST}Set the type of tiny-whoop (tiny65bl, tiny75bl)"
            echo -e "${C_MSG}  -x                  ${C_RST}Set the number of tiny-whoops in the length of a box and a drawer"
            echo -e "${C_MSG}  -y                  ${C_RST}Set the number of tiny-whoops in the width of a box and a drawer"
            echo -e "${C_MSG}  -b,  --box          ${C_RST}Set the number of tiny-whoops in both directions for a box"
            echo -e "${C_MSG}  -bx, --boxX         ${C_RST}Set the number of tiny-whoops in the length of a box"
            echo -e "${C_MSG}  -by, --boxY         ${C_RST}Set the number of tiny-whoops in the width of a box"
            echo -e "${C_MSG}  -d,  --drawer       ${C_RST}Set the number of tiny-whoops in both directions for a drawer"
            echo -e "${C_MSG}  -dx, --drawerX      ${C_RST}Set the number of tiny-whoops in the length of a drawer"
            echo -e "${C_MSG}  -dy, --drawerY      ${C_RST}Set the number of tiny-whoops in the width of a drawer"
            echo -e "${C_MSG}  -ds, --drawers      ${C_RST}Set the number of drawers"
            echo
            exit 0
        ;;
        *)
            ls $1 >/dev/null 2>&1
            if [ "$?" == "0" ]; then
                src=$1
            else
                echo -e "${C_ERR}"
                echo -e "${C_ERR}Unknown parameter ${1}${C_RST}"
                echo -e "${C_RST}"
                exit 1
            fi
        ;;
    esac
    shift
done

# compose value for the number of tiny-whoops per container
if [ "${boxX}" != "" ] || [ "${boxY}" != "" ]; then
    if [ "${boxX}" == "" ]; then
        boxX="1"
    fi
    if [ "${boxY}" == "" ]; then
        boxY="1"
    fi
    whoopCountBox="whoopCountBox=[${boxX}, ${boxY}]"
fi

# compose value for the number of tiny-whoops per drawer
if [ "${drawerX}" != "" ] || [ "${drawerY}" != "" ]; then
    if [ "${drawerX}" == "" ]; then
        drawerX="1"
    fi
    if [ "${drawerY}" == "" ]; then
        drawerY="1"
    fi
    whoopCountDrawer="whoopCountDrawer=[${drawerX}, ${drawerY}]"
fi

# compose value for the number of drawers
if [ "${drawers}" != "" ]; then
    drawerCountCupboard="drawerCountCupboard=${drawers}"
fi

# create the output folder if needed
if [ ! -d "${dstpath}" ]; then
    echo -e "${C_SEL}Create output folder.${C_RST}"
    mkdir -p "${dstpath}" >/dev/null

    if [ ! -d "${dstpath}" ]; then
        echo -e "${C_ERR}"
        echo "Cannot create output folder!"
        echo -e "${C_RST}"
        exit 1
    fi
fi

# check OpenSCAD
echo -e "Detecting ${C_SPE}OpenSCAD${C_RST}..."
openscad -v >/dev/null 2>&1
if [ "$?" != "0" ]; then
    echo -e "${C_ERR}"
    echo "It seems OpenSCAD has not been installed on your system."
    echo "Or perhaps is it just not reachable..."
    echo "Have you placed it in your environment PATH variable?"
    echo -e "${C_RST}"
    exit 3
fi

echo -e "${C_SPE}OpenSCAD${C_RST} has been detected."
echo -e "${C_RST}"
echo -e "${C_RST}Processing rendering from ${C_CTX}${project}"
echo -e "${C_RST}"

# render the files, if exist
ls ${src} >/dev/null 2>&1
if [ "$?" == "0" ]; then
    for filename in ${src}; do
        render "${filename}"
    done
else
    echo -e "${C_ERR}"
    echo "There is nothing to render!"
    echo -e "${C_RST}"
    exit 1
fi

echo -e "${C_RST}"
echo "Done!"
