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
 * Angled box that will contain a tiny-whoop and its surrounding protection box.
 * This should be printed in rigid material, like PLA.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../config/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 5])
    whoopAngledBox(
        motorDistance = motorDistance,
        ductDiameter = ductDiameter,
        wallThickness = getBoxWallThickness(ANGLED_BOX),
        groundThickness = getBoxGroundThickness(ANGLED_BOX),
        boxHeight = getBoxHeight(ANGLED_BOX, whoopHeight),
        ductDistance = getBoxWhoopDistance(ANGLED_BOX)
    );
}
