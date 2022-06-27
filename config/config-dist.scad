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
 * A box to store tiny-whoops.
 *
 * Global configuration.
 *
 * @author jsconan
 */

// We will render the object using the specifications of this mode.
renderMode = MODE_PROD;

// Defines the characteristics of the printer
layerHeight = 0.2;          // The height of the printed layers.
nozzleWidth = 0.4;          // The size of the printer's nozzle.
printTolerance = 0.1;       // The print tolerance when pieces need to be assembled.
printInterval = 5;          // The interval between 2 pieces when presented together.
printerLength = 250;        // The length of the printer's build plate.
printerWidth = 210;         // The width of the printer's build plate.

// Defines the size of a tiny-whoop
preset = "DEFAULT";
motorDistance = getPreset(preset, IDX_MOTOR_DISTANCE);   // The distance between motors on the diagonal.
ductDiameter = getPreset(preset, IDX_DUCT_DIAMETER);     // The outer diameter of a motor duct.
ductHeight = getPreset(preset, IDX_DUCT_HEIGHT);         // The outer height of a motor duct, including the screw heads.
whoopHeight = getPreset(preset, IDX_WHOOP_HEIGHT);       // The outer height of the tiny-whoop, from the bottom of the frame to the top of the canopy, including everything beyond.
boxPadding = getPreset(preset, IDX_BOX_PADDING);         // The width of padding between the box sides and the tiny-whoop.

// Specifications for the boxes
wallThickness = 0.8;        // The thickness of the box walls.
groundThickness = 0.8;      // The thickness of the box ground.
boxIndentation = [30, 10];  // Defines the size of a handle indentation, it will be cut from each box side. The first value represents the top width, the second represents the bottom width and the depth.
outerDistance = 0.5;        // The distance between a box and its container. This is additional size added to the container inner room to fit the box.

// Sets the count of tiny-whoops in each kind of box
whoopBoxHor = 1;            // The number of boxes per lines in the container (horizontal axis).
whoopBoxVer = 1;            // The number of boxes per columns in the container (vertical axis).
whoopBoxDrw = 1;            // The number of drawers in the cupboard.

// Options for the ready to print models
showConfig = 0;             // Show the config when rendering a model. The render script uses it to extract the config