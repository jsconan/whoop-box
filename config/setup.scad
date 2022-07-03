/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2019-2022 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/whoop-box.
 *
 * jsconan/whoop-box is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/whoop-box is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/whoop-box. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A box to store a tiny whoop.
 *
 * Project's bootstrap.
 *
 * @author jsconan
 */

// As we need to use some shapes, use the right entry point of the library.
include <../lib/camelSCAD/shapes.scad>

// Defines the project's version
include <version.scad>

// Then we need the config for the project, as well as the related functions
include <constants.scad>
include <helpers.scad>
include <presets.scad>
include <config.scad>

// Finally, include the shapes
include <../shapes/box-util.scad>
include <../shapes/whoop-box.scad>
include <../shapes/rounded-box.scad>
include <../shapes/angled-box.scad>
include <../shapes/angled-container.scad>
include <../shapes/angled-drawer.scad>
include <../shapes/angled-cupboard.scad>

// Show the config values
if (showConfig) {
    echo(join([
        "",
        str("-- Tiny-Whoop boxes System ----------"),
        str("Version:                       ", printVersion()),
        str("Preset:                        ", preset),
        str("-- Tiny-Whoop settings --------------"),
        str("Motor distance:                ", motorDistance, "mm"),
        str("Duct diameter:                 ", ductDiameter, "mm"),
        str("Duct height:                   ", ductHeight, "mm"),
        str("Whoop height:                  ", whoopHeight, "mm"),
        str("Box padding:                   ", boxPadding, "mm"),
        str("-- Box settings ---------------------"),
        str("Wall thickness:                ", wallThickness, "mm"),
        str("Ground thickness:              ", groundThickness, "mm"),
        str("Outer distance:                ", outerDistance, "mm"),
        str("Boxes per lines:               ", whoopBoxX),
        str("Boxes per columns:             ", whoopBoxY),
        str("Boxes per lines and columns:   ", whoopBoxZ),
        str("-- Printer settings -----------------"),
        str("Nozzle diameter:               ", nozzleWidth, "mm"),
        str("Print layer:                   ", layerHeight, "mm"),
        str("Print tolerance:               ", printTolerance, "mm"),
        str("Printer's length:              ", printerLength / 10, "cm"),
        str("Printer's width:               ", printerWidth / 10, "cm"),
        str("Print interval:                ", printInterval, "mm"),
        ""
    ], "\n"));
}


// Show the list of available presets
if (showPresets) {
    echo(str(
        "\n",
        join(getPresets(IDX_NAME), "\n"),
        "\n"
    ));
}
