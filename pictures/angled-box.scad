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
 * Shows the angled box for a tiny-whoop.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../config/setup.scad>

// Setup the viewport
$vpr = [40, 0, 340];
$vpt = [0, 0, 25];
$vpd = 330;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    color(colorAngledBox) {
        angledBox(
            motorDistance = motorDistance,
            ductDiameter = ductDiameter,
            wallThickness = wallThickness,
            groundThickness = groundThickness,
            boxHeight = getBoxHeight(whoopHeight=whoopHeight, groundThickness=groundThickness, shells=1),
            wallDistance = getWallDistance(wallThickness=wallThickness, shells=1)
        );
    }
}
