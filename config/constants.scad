/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2022 Jean-Sebastien CONAN
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

// Defines the indexes in the presets
IDX_NAME = 0;           // The index for the preset name
IDX_MOTOR_DISTANCE = 1; // The index for the distance between motors on the diagonal.
IDX_DUCT_DIAMETER = 2;  // The index for the outer diameter of a motor duct.
IDX_DUCT_HEIGHT = 3;    // The index for the outer height of a motor duct, including everything beyond like the screw heads.
IDX_WHOOP_HEIGHT = 4;   // The index for the outer height of the tiny-whoop, from the bottom of the frame to the top of the canopy, including everything beyond.
IDX_BOX_PADDING = 5;    // The index for the width of padding between the box sides and the tiny-whoop.