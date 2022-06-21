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
 * Defines the config.
 *
 * @author jsconan
 */

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints of the print.
printResolution = 0.2;  // the target layer height
nozzle = 0.4;           // the size of the print nozzle
wallDistance = 0.1;     // the distance between the walls of two objects

// Defines the indexes in the datasets
IDX_ID = 0;             // index of the identifier
// - Tiny Whoop data
IDX_WHOOP_DUCT = 1;     // index of the duct diameter in whoop data
IDX_WHOOP_FRAME = 2;    // index of the frame diagonal in whoop data
IDX_WHOOP_HEIGHT = 3;   // index of the height in whoop data
// - Box data
IDX_BOX_WALL = 1;       // index of the wall thickness in box data
IDX_BOX_GROUND = 2;     // index of the ground thickness in box data
IDX_BOX_HEIGHT = 3;     // index of the height addition in box data
IDX_BOX_DISTANCE = 4;   // index of the distance to walls factor in box data

// Defines the types of data
TINY_WHOOP_65_BL = "tiny65bl";
TINY_WHOOP_75_BL = "tiny75bl";
ROUNDED_BOX = "rounded";
ANGLED_BOX = "angled";
CONTAINER = "drawer";
DRAWER = "drawer";
CUPBOARD = "cupboard";

// Defines the size for each types of tiny-whoops
whoopData = [
    // id,             duct, frame, height
    [TINY_WHOOP_65_BL,  37,   65,    48],
    [TINY_WHOOP_75_BL,  48,   76,    48],
];

// Defines the constraints for the tiny-whoops boxes
boxData = [
    // id,         wall, ground, height addition, distance factor
    [ROUNDED_BOX,   0.8,  1,     -1,               1],
    [ANGLED_BOX,    1.0,  1,      0,               1],
    [DRAWER,        1.6,  1,      1,               4],
    [CUPBOARD,      2.0,  2,      0,               4],
];

// Defines the size of a box indentation
boxIndentation = [30, 10];

// Defines the size of a handle hole
boxHandleHole = 20;

// Defines the target tiny-whoop type
whoopType = TINY_WHOOP_65_BL;

// Sets the count of tiny-whoops in each kind of box
whoopCountBox = 2;
whoopCountDrawer = 2;
drawerCountCupboard = 2;
