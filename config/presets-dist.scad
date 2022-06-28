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
 * Defines config presets for various tiny-whoop.
 *
 * @author jsconan
 */

// Defines the size of tiny-whoops
presets = [
    [
        // frame 65, props 31
        "DEFAULT",              // IDX_NAME
        65,                     // IDX_MOTOR_DISTANCE
        37,                     // IDX_DUCT_DIAMETER
        20,                     // IDX_DUCT_HEIGHT
        48,                     // IDX_WHOOP_HEIGHT
        7                       // IDX_BOX_PADDING
    ],
    [
        // frame 65, props 31
        "METEOR65",             // IDX_NAME
        65,                     // IDX_MOTOR_DISTANCE
        36,                     // IDX_DUCT_DIAMETER
        17,                     // IDX_DUCT_HEIGHT
        40,                     // IDX_WHOOP_HEIGHT
        7.5                     // IDX_BOX_PADDING
    ],
    [
        // frame 65, props 31, HD
        "METEOR65HD",           // IDX_NAME
        65,                     // IDX_MOTOR_DISTANCE
        36,                     // IDX_DUCT_DIAMETER
        17,                     // IDX_DUCT_HEIGHT
        43,                     // IDX_WHOOP_HEIGHT
        7.5                     // IDX_BOX_PADDING
    ],
    [
        // frame 65, props 35
        "METEOR65PRO",          // IDX_NAME
        65,                     // IDX_MOTOR_DISTANCE
        39,                     // IDX_DUCT_DIAMETER
        16,                     // IDX_DUCT_HEIGHT
        40,                     // IDX_WHOOP_HEIGHT
        6                       // IDX_BOX_PADDING
    ],
    [
        // frame 75, props 40
        "BETA75X",              // IDX_NAME
        78,                     // IDX_MOTOR_DISTANCE
        48,                     // IDX_DUCT_DIAMETER
        28,                     // IDX_DUCT_HEIGHT
        54,                     // IDX_WHOOP_HEIGHT
        1                       // IDX_BOX_PADDING
    ],
    [
        // frame 75, props 40, HD
        "BETA75HD",             // IDX_NAME
        78,                     // IDX_MOTOR_DISTANCE
        48,                     // IDX_DUCT_DIAMETER
        28,                     // IDX_DUCT_HEIGHT
        65,                     // IDX_WHOOP_HEIGHT
        1                       // IDX_BOX_PADDING
    ]
];
