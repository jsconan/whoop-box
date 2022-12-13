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
 * Builds a box that will contain tiny-whoop batteries.
 * @param Number batteryWidth - The battery width.
 * @param Number batteryHeight - The battery height.
 * @param Number batteryLength - The battery length.
 * @param Number wallThickness - The thickness of the walls.
 * @param Number groundThickness - The thickness of the ground.
 * @param Number|Vector [cells] - The number of batteries per box. It gives the number on the horizontal and vertical axis.
 */
module whoopBatteryBox(batteryWidth, batteryHeight, batteryLength, wallThickness, groundThickness, cells=[1, 1]) {
    cells = vector2D(cells);
    outerLength = wallThickness + (batteryHeight + wallThickness) * cells.x;
    outerWidth = wallThickness + (batteryWidth + wallThickness) * cells.y;
    outerHeight = groundThickness + batteryLength;

    difference() {
        box([outerLength, outerWidth, outerHeight]);
        translateZ(groundThickness) {
            repeatShape2D(size=[batteryHeight + wallThickness, batteryWidth + wallThickness], count=cells, center=true) {
                box([batteryHeight, batteryWidth, outerHeight]);
            }
        }
    }
}
