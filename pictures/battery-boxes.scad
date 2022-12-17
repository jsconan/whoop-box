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
 * Box that will contain tiny-whoop's batteries.
 * This should be printed in rigid material, like PLA or PETG.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../config/setup.scad>

// Setup the viewport
$vpr = [50, 0, 50];
$vpt = [0, 0, 25];
$vpd = 330;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    %translateZ(batteryLength + groundThickness * 2) {
        rotateY(180) {
            color(colorBatteryBoxCover) {
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
    }
    color(colorBatteryBoxContainer) {
        whoopBatteryBox(
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
