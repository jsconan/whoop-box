/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2019 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/things.
 *
 * jsconan/things is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/things is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/things. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A box to store tiny-whoops.
 *
 * Rounded box that will directly contain a tiny-whoop.
 * This should be printed in a soft and rubber material, like TPU.
 *
 * @author jsconan
 * @version 0.1.0
 */

// Import the project's setup.
include <util/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
buildBox(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 10], offset=[0, 0, 5])
    whoopRoundedBox(
        whoopType = whoopType,
        wallThickness = getBoxWallThickness(ROUNDED_BOX),
        groundThickness = getBoxGroundThickness(ROUNDED_BOX),
        boxHeight = getBoxHeight(ROUNDED_BOX, whoopType),
        ductDistance = getBoxWhoopDistance(ROUNDED_BOX)
    );
}
