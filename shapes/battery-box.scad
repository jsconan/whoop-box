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
 * A box to store tiny-whoop.
 *
 * Defines the shapes for a box to store tiny-whoop's batteries.
 *
 * @author jsconan
 */

/**
 * Gets the outer size of a box that will contain tiny-whoop batteries.
 * @param Number batteryWidth - The battery width.
 * @param Number batteryHeight - The battery height.
 * @param Number batteryLength - The battery length.
 * @param Number wallThickness - The thickness of the walls.
 * @param Number groundThickness - The thickness of the ground.
 * @param Number|Vector [cells] - The number of batteries per box. It gives the number on the horizontal and vertical axis.
 * @param Number wallDistance - The distance between the battery and the wall.
 * @return Vector - The outer size of the box.
 */
function whoopBatterySize(batteryWidth, batteryHeight, batteryLength, wallThickness, groundThickness, cells=[1, 1], wallDistance = 0) =
    let(
        cells = vector2D(cells),
        distance = wallDistance * 2,
        batteryBoxHeight = layerAligned(batteryLength * 65 / 100),
        outerLength = wallThickness + (batteryHeight + wallThickness + distance) * cells.x,
        outerWidth = wallThickness + (batteryWidth + wallThickness + distance) * cells.y,
        outerHeight = groundThickness + batteryBoxHeight
    )
    [
        outerLength,
        outerWidth,
        outerHeight
    ]
;

/**
 * Builds a box that will contain tiny-whoop batteries.
 * @param Number batteryWidth - The battery width.
 * @param Number batteryHeight - The battery height.
 * @param Number batteryLength - The battery length.
 * @param Number wallThickness - The thickness of the walls.
 * @param Number groundThickness - The thickness of the ground.
 * @param Number|Vector [cells] - The number of batteries per box. It gives the number on the horizontal and vertical axis.
 * @param Number wallDistance - The distance between the battery and the wall.
 */
module whoopBatteryBox(batteryWidth, batteryHeight, batteryLength, wallThickness, groundThickness, cells=[1, 1], wallDistance = 0) {
    cells = vector2D(cells);
    size = whoopBatterySize(
        batteryWidth = batteryWidth,
        batteryHeight = batteryHeight,
        batteryLength = batteryLength,
        wallThickness = wallThickness,
        groundThickness = groundThickness,
        cells = cells,
        wallDistance = wallDistance
    );

    distance = wallDistance * 2;
    width = batteryWidth + distance;
    height = batteryHeight + distance;

    difference() {
        box(size);
        translateZ(groundThickness) {
            repeatShape2D(size=[height + wallThickness, width + wallThickness], count=cells, center=true) {
                box([height, width, size.z]);
            }
        }
    }
}

/**
 * Builds a cover for a tiny-whoop batteries box.
 * @param Number batteryWidth - The battery width.
 * @param Number batteryHeight - The battery height.
 * @param Number batteryLength - The battery length.
 * @param Number wallThickness - The thickness of the walls.
 * @param Number groundThickness - The thickness of the ground.
 * @param Number|Vector [cells] - The number of batteries per box. It gives the number on the horizontal and vertical axis.
 * @param Number wallDistance - The distance between the box and the cover.
 */
module whoopBatteryCover(batteryWidth, batteryHeight, batteryLength, wallThickness, groundThickness, cells=[1, 1], wallDistance = 0) {
    cells = vector2D(cells);
    size = whoopBatterySize(
        batteryWidth = batteryWidth,
        batteryHeight = batteryHeight,
        batteryLength = batteryLength,
        wallThickness = wallThickness,
        groundThickness = groundThickness,
        cells = cells,
        wallDistance = wallDistance
    );

    distance = wallDistance * 2;
    addition = wallThickness * 2 + distance;
    innerSize = size + [distance, distance, groundThickness];
    outerSize = size + [addition, addition, 0];
    handle = outerSize.y / 2;

    width = batteryWidth + distance;
    height = batteryHeight + distance;

    difference() {
        box(outerSize);
        translateZ(groundThickness) {
            box(innerSize);
        }
        translateZ(outerSize.z) {
            rotateX(90) {
                cylinder(r=handle, h=outerSize.y + wallThickness, center=true);
            }
        }
    }
    translateZ(groundThickness) {
        repeatShape2D(size=[height + wallThickness, width + wallThickness], count=cells - [1, 0], center=true) {
            box([wallThickness, size.y + wallThickness, batteryWidth]);
        }
    }
}
