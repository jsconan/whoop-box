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
 * Test the battery boxes.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../config/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    %translateZ(batteryLength + groundThickness * 2 + 1) {
        rotateY(180) {
            whoopBatteryCover(
                batteryWidth = batteryWidth,
                batteryHeight = batteryHeight,
                batteryLength = batteryLength,
                wallThickness = wallThickness,
                groundThickness = groundThickness,
                wallDistance = printTolerance,
                cells = [batteryNumber, 1]
            );
        }
    }
    whoopBatteryBox(
        batteryWidth = batteryWidth,
        batteryHeight = batteryHeight,
        batteryLength = batteryLength,
        wallThickness = wallThickness,
        groundThickness = groundThickness,
        cells = [batteryNumber, 1]
    );
}
