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

// Defines the size of each tiny-whoop for which build a box.
presets = [
    [
        // frame 65, props 31
        "DEFAULT",              // IDX_NAME
        65,                     // IDX_MOTOR_DISTANCE
        37,                     // IDX_DUCT_DIAMETER
        23,                     // IDX_DUCT_HEIGHT
        48,                     // IDX_WHOOP_HEIGHT
        7,                      // IDX_BOX_PADDING
        false,                  // IDX_BOX_SEPARATOR
        1,                      // IDX_BOX_X
        2,                      // IDX_BOX_Y
        1,                      // IDX_BOX_Z
    ],
    [
        // frame 65, props 31
        "METEOR65",             // IDX_NAME
        65,                     // IDX_MOTOR_DISTANCE
        36,                     // IDX_DUCT_DIAMETER
        17,                     // IDX_DUCT_HEIGHT
        40,                     // IDX_WHOOP_HEIGHT
        7.5,                    // IDX_BOX_PADDING
        false,                  // IDX_BOX_SEPARATOR
        1,                      // IDX_BOX_X
        2,                      // IDX_BOX_Y
        1,                      // IDX_BOX_Z
    ],
    [
        // frame 65, props 31, HD
        "METEOR65HD",           // IDX_NAME
        65,                     // IDX_MOTOR_DISTANCE
        36,                     // IDX_DUCT_DIAMETER
        17,                     // IDX_DUCT_HEIGHT
        43,                     // IDX_WHOOP_HEIGHT
        7.5,                    // IDX_BOX_PADDING
        false,                  // IDX_BOX_SEPARATOR
        1,                      // IDX_BOX_X
        2,                      // IDX_BOX_Y
        1,                      // IDX_BOX_Z
    ],
    [
        // frame 65, props 35
        "METEOR65PRO",          // IDX_NAME
        65,                     // IDX_MOTOR_DISTANCE
        39,                     // IDX_DUCT_DIAMETER
        16,                     // IDX_DUCT_HEIGHT
        40,                     // IDX_WHOOP_HEIGHT
        6,                      // IDX_BOX_PADDING
        false,                  // IDX_BOX_SEPARATOR
        1,                      // IDX_BOX_X
        2,                      // IDX_BOX_Y
        1,                      // IDX_BOX_Z
    ],
    [
        // frame 65, props 35, 2022 update
        "METEOR65PRO2022",      // IDX_NAME
        66,                     // IDX_MOTOR_DISTANCE
        40,                     // IDX_DUCT_DIAMETER
        17,                     // IDX_DUCT_HEIGHT
        38,                     // IDX_WHOOP_HEIGHT
        5,                      // IDX_BOX_PADDING
        false,                  // IDX_BOX_SEPARATOR
        2,                      // IDX_BOX_X
        1,                      // IDX_BOX_Y
        1,                      // IDX_BOX_Z
    ],
    [
        // frame 75, props 40
        "BETA75X",              // IDX_NAME
        78,                     // IDX_MOTOR_DISTANCE
        48,                     // IDX_DUCT_DIAMETER
        28,                     // IDX_DUCT_HEIGHT
        56,                     // IDX_WHOOP_HEIGHT
        1,                      // IDX_BOX_PADDING
        false,                  // IDX_BOX_SEPARATOR
        1,                      // IDX_BOX_X
        2,                      // IDX_BOX_Y
        1,                      // IDX_BOX_Z
    ],
    [
        // frame 75, props 40, HD
        "BETA75HD",             // IDX_NAME
        78,                     // IDX_MOTOR_DISTANCE
        48,                     // IDX_DUCT_DIAMETER
        28,                     // IDX_DUCT_HEIGHT
        65,                     // IDX_WHOOP_HEIGHT
        1,                      // IDX_BOX_PADDING
        false,                  // IDX_BOX_SEPARATOR
        1,                      // IDX_BOX_X
        2,                      // IDX_BOX_Y
        1,                      // IDX_BOX_Z
    ],
    [
        // frame 65, parts box
        "PARTS65",              // IDX_NAME
        65,                     // IDX_MOTOR_DISTANCE
        36,                     // IDX_DUCT_DIAMETER
        0,                      // IDX_DUCT_HEIGHT
        43,                     // IDX_WHOOP_HEIGHT
        7.5,                    // IDX_BOX_PADDING
        false,                  // IDX_BOX_SEPARATOR
        1,                      // IDX_BOX_X
        2,                      // IDX_BOX_Y
        1,                      // IDX_BOX_Z
    ],
    [
        // frame 75, parts box low profile
        "PARTS75LO",            // IDX_NAME
        78,                     // IDX_MOTOR_DISTANCE
        48,                     // IDX_DUCT_DIAMETER
        0,                      // IDX_DUCT_HEIGHT
        56,                     // IDX_WHOOP_HEIGHT
        1,                      // IDX_BOX_PADDING
        false,                  // IDX_BOX_SEPARATOR
        1,                      // IDX_BOX_X
        2,                      // IDX_BOX_Y
        1,                      // IDX_BOX_Z
    ],
    [
        // frame 75, parts box high profile
        "PARTS75HI",            // IDX_NAME
        78,                     // IDX_MOTOR_DISTANCE
        48,                     // IDX_DUCT_DIAMETER
        0,                      // IDX_DUCT_HEIGHT
        65,                     // IDX_WHOOP_HEIGHT
        1,                      // IDX_BOX_PADDING
        false,                  // IDX_BOX_SEPARATOR
        1,                      // IDX_BOX_X
        2,                      // IDX_BOX_Y
        1,                      // IDX_BOX_Z
    ],
    [
        // frame 65, props box
        "PROPS65",              // IDX_NAME
        65,                     // IDX_MOTOR_DISTANCE
        36,                     // IDX_DUCT_DIAMETER
        0,                      // IDX_DUCT_HEIGHT
        39,                     // IDX_WHOOP_HEIGHT
        7.5,                    // IDX_BOX_PADDING
        true,                   // IDX_BOX_SEPARATOR
        1,                      // IDX_BOX_X
        2,                      // IDX_BOX_Y
        1,                      // IDX_BOX_Z
    ],
    [
        // frame 75, props box
        "PROPS75",              // IDX_NAME
        78,                     // IDX_MOTOR_DISTANCE
        48,                     // IDX_DUCT_DIAMETER
        0,                      // IDX_DUCT_HEIGHT
        39,                     // IDX_WHOOP_HEIGHT
        1,                      // IDX_BOX_PADDING
        true,                   // IDX_BOX_SEPARATOR
        1,                      // IDX_BOX_X
        2,                      // IDX_BOX_Y
        1,                      // IDX_BOX_Z
    ]
];

// Defines the size of each battery for which build a box.
batteries = [
    [
        // Generic 1S 200mAh to 300mAh
        "DEFAULT",              // IDX_NAME
        12,                     // IDX_BATTERY_WIDTH
        7,                      // IDX_BATTERY_HEIGHT
        60,                     // IDX_BATTERY_LENGTH
        6,                      // IDX_BATTERY_NUMBER
    ],
    [
        // 1S HV 300mAh
        "1S-300",               // IDX_NAME
        12,                     // IDX_BATTERY_WIDTH
        7,                      // IDX_BATTERY_HEIGHT
        68,                     // IDX_BATTERY_LENGTH
        6,                      // IDX_BATTERY_NUMBER
    ],
    [
        // 1S HV 450mAh
        "1S-450",               // IDX_NAME
        17.5,                   // IDX_BATTERY_WIDTH
        7.5,                    // IDX_BATTERY_HEIGHT
        68,                     // IDX_BATTERY_LENGTH
        6,                      // IDX_BATTERY_NUMBER
    ],
];
