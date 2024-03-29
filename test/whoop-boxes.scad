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
 * Test the whoop boxes.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../config/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    %translateZ(wallThickness) {
        rotateX(90) {
            whoopBoxContainer(
                motorDistance = motorDistance,
                ductDiameter = ductDiameter,
                wallThickness = wallThickness,
                containerThickness = containerThickness,
                linkThickness = linkThickness,
                boxHeight = getBoxHeight(whoopHeight=whoopHeight, groundThickness=groundThickness),
                paddingWidth = boxPadding,
                wallDistance = outerDistance,
                cells = [1, 1]
            );
        }
    }
    translateZ(-getBoxHeight(whoopHeight=whoopHeight, groundThickness=groundThickness) / 2 + outerDistance) {
        whoopBox(
            motorDistance = motorDistance,
            ductDiameter = ductDiameter,
            wallThickness = wallThickness,
            groundThickness = groundThickness,
            boxHeight = getBoxHeight(whoopHeight=whoopHeight, groundThickness=groundThickness),
            paddingWidth = boxPadding,
            paddingHeight = ductHeight,
            wallDistance = getWallDistance(wallThickness=wallThickness),
            separator = boxSeparators
        );
    }
}
