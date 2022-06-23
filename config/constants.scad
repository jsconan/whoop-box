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
 * Global constants.
 *
 * @author jsconan
 */

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
ROUNDED_BOX = "rounded";
ANGLED_BOX = "angled";
CONTAINER = "drawer";
DRAWER = "drawer";
CUPBOARD = "cupboard";

// Defines the constraints for the tiny-whoops boxes
boxData = [
    // id,         wall, ground, height addition, distance factor
    [ROUNDED_BOX,   0.8,  1,     -1,               1],
    [ANGLED_BOX,    1.0,  1,      0,               1],
    [DRAWER,        1.6,  1,      1,               4],
    [CUPBOARD,      2.0,  2,      0,               4],
];
