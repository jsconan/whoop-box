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
 * Global functions.
 *
 * @author jsconan
 */

/**
 * Aligns a value with respect to the target layer height.
 * @param Number value
 * @returns Number
 */
function layerAligned(value) = roundBy(value, layerHeight);

/**
 * Aligns a value with respect to the target nozzle size.
 * @param Number value
 * @returns Number
 */
function nozzleAligned(value) = roundBy(value, nozzleWidth);

/**
 * Gets the thickness of N layers.
 * @param Number N
 * @returns Number
 */
function layers(N) = N * layerHeight;

/**
 * Gets the width of N times the nozzle width.
 * @param Number N
 * @returns Number
 */
function shells(N) = N * nozzleWidth;

/**
 * Computes the print interval between the centers of 2 objects.
 * @param Number size - The size of the shape.
 * @returns Number
 */
function getPrintInterval(size) = size + printInterval;

/**
 * Gets the adjusted quantity of shapes to place on a grid with respect to the size of one shape.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @returns Number
 */
function getMaxQuantity(length, width, quantity=1) =
    let(
        maxLine = floor(printerLength / length),
        maxCol = floor(printerWidth / width)
    )
    min(maxLine * maxCol, quantity)
;

/**
 * Gets the maximal number of shapes that can be placed on a line with respect the size of one shape.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @param Number [line] - The expected number of shapes per line.
 * @returns Number
 */
function getMaxLine(length, width, quantity=1, line=undef) =
    let(
        maxLine = floor(printerLength / length)
    )
    min(uor(line, ceil(sqrt(quantity))), maxLine)
;

/**
 * Gets the overall length of the area taken to place the repeated shapes on a grid with respect to the expected quantity.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @param Number [line] - The expected number of shapes per line.
 * @returns Number
 */
function getGridLength(length, width, quantity=1, line=undef) =
    let(
        length = getPrintInterval(length),
        width = getPrintInterval(width),
        quantity = getMaxQuantity(length, width, quantity)
    )
    min(quantity, getMaxLine(length, width, quantity, line)) * length
;

/**
 * Gets the overall width of the area taken to place the repeated shapes on a grid with respect to the expected quantity.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @param Number [line] - The expected number of shapes per line.
 * @returns Number
 */
function getGridWidth(length, width, quantity=1, line=undef) =
    let(
        length = getPrintInterval(length),
        width = getPrintInterval(width),
        quantity = getMaxQuantity(length, width, quantity),
        line = getMaxLine(length, width, quantity, line)
    )
    ceil(quantity / line) * width
;

/**
 * Prints the project version, including the package version.
 * @returns String
 */
function printVersion() = str(PROJECT_VERSION);

/**
 * Gets the preset defined by a name, or a value from a preset.
 * @param String name - The name of the preset to get.
 * @param Number [index] - The index inside the preset for the value to get.
 * @param * [default] - The default value if the preset does not exist at the given index.
 * @returns Array|Number - The preset or the value at index.
 */
function getPreset(name, index, default) =
    let(
        data = uor(fetch(presets, name), fetch(presets, "DEFAULT"))
    )
    index ? uor(data[index], default) : data
;

/**
 * Gets the list of preset values.
 * @param Number index - The index inside each preset for the value to get.
 * @returns Array - The list of preset values.
 */
function getPresets(index) = [ for (preset = presets) preset[index] ];

/**
 * Computes the side distance between motors based on the given diagonal.
 * @param Number diagonal - The distance between motors on the diagonal.
 * @returns Number - The distance between motors.
 */
function getMotorInterval(diagonal) = sqrt(pow(diagonal, 2) / 2);

/**
 * Computes the outer width of a box that will contain a tiny-whoop.
 * @param Number motorDistance - The distance between motors on the diagonal.
 * @param Number ductDiameter - The outer diameter of a motor duct.
 * @param Number wallThickness - The thickness of the walls.
 * @param Number wallDistance - The distance between a duct and the wall.
 */
function getBoxWidth(motorDistance, ductDiameter, wallThickness, wallDistance) =
    let(
        motorDistance = float(motorDistance),
        ductDiameter = float(ductDiameter),
        wallThickness = float(wallThickness),
        wallDistance = float(wallDistance)
    )
    ceil(getMotorInterval(motorDistance)) + ductDiameter + (wallDistance + wallThickness) * 2
;

/**
 * Computes the outer height of a box that will contain a tiny-whoop.
 * @param Number whoopHeight - The outer height of the tiny-whoop.
 * @param Number groundThickness - The thickness of the box ground.
 * @param Number shells - The number of shells. This represents the number of nested boxes.
 */
function getBoxHeight(whoopHeight, groundThickness, shells) =
    let(
        whoopHeight = float(whoopHeight),
        groundThickness = float(groundThickness),
        shells = float(shells) + 1
    )
    layerAligned(whoopHeight + groundThickness * (shells * 2 - 1))
;

/**
 * Computes the distance between the walls and the ducts of the tiny-whoop.
 * @param Number wallThickness - The thickness of the walls.
 * @param Number shells - The number of shells. This represents the number of nested boxes.
 */
function getWallDistance(wallThickness, shells) =
    let(
        wallThickness = float(wallThickness),
        shells = float(shells)
    )
    printTolerance + (wallThickness + printTolerance) * shells
;

/**
 * Gets the radius of a tiny-whoop duct.
 * @param Number sides - The number of sides of the duct
 * @param Number diameter - The diameter of the duct
 * @returns Vector - The radius of the duct, as a 2D vector
 */
function getDuctRadius(sides, diameter) =
    vector2D(
        circumradius(n=sides, a=float(diameter) / 2)
    )
;

/**
 * Gets the distance between external ducts, for one or more tiny-whoops.
 * @param Number interval - The interval between ducts
 * @param Number diameter - The diameter of a duct
 * @param Vector count - The count of tiny-whoops in each direction
 * @param Number wall - The thickness of a wall
 * @returns Vector - The distance between external ducts
 */
function getDuctDistance(interval, diameter, count=1, wall=0) =
    let(
        count = vector2D(count),
        interval = float(interval),
        width = interval + float(diameter) + float(wall)
    )
    vadd(width * (count - [1, 1]), interval)
;

/**
 * Gets the points for each duct of a tiny-whoop.
 * @param Number interval - The interval between ducts
 * @param Number diameter - The diameter of a duct
 * @param Vector count - The count of tiny-whoops in each direction
 * @param Number wall - The thickness of a wall
 * @returns Vector - The distance between external ducts
 */
function getDuctPoints(interval, diameter, count=1, wall=0) =
    let(
        point = getDuctDistance(interval, diameter, count, wall) / 2
    )
    [ for (i = [0:3])
        quadrant(point, i)
    ]
;
