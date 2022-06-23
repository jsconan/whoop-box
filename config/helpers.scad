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
function printVersion() = str(PROJECT_VERSION, " (package: ", PACKAGE_VERSION, ")");


/** OLD HELPERS **/

/**
 * Gets the data defined for a particular tiny-whoop type
 * @param String whoopType - The type of tiny-whoop
 * @param Number [index] - The index of the data to get
 * @returns Array|Number - The tiny-whoop data
 */
function getWhoopData(whoopType, index) =
    let(
        data = fetch(whoopData, whoopType)
    )
    index ? data[index] : data
;

/**
 * Gets the data defined for a particular box type
 * @param String boxType - The type of box
 * @param Number [index] - The index of the data to get
 * @returns Array|Number - The box data
 */
function getBoxData(boxType, index) =
    let(
        data = fetch(boxData, boxType)
    )
    index ? data[index] : data
;

/**
 * Gets the cumulative data defined for a particular box type
 * @param String boxType - The type of box
 * @param Number index - The index of the data to sum
 * @returns Number - The box cumulative data
 */
function getBoxCumulativeData(boxType, index) =
    let(
        dataIndex = find(boxData, boxType)
    )
    vsum([
        for (boxIndex = [0:dataIndex])
            boxData[boxIndex][index]
    ])
;

/**
 * Gets the list of box types till the provided one
 * @param String boxType - The type of box
 * @returns Array - The box cumulative data
 */
function getBoxTypeList(boxType) =
    let(
        dataIndex = find(boxData, boxType)
    )
    [
        for (boxIndex = [0:dataIndex])
            boxData[boxIndex][IDX_ID]
    ]
;

/**
 * Gets the diameter of the propeller duct
 * @param String whoopType - The type of tiny-whoop for which compute the size
 * @returns Number - The diameter of the propeller duct
 */
function getWhoopDuctDiameter(whoopType) = getWhoopData(whoopType, IDX_WHOOP_DUCT);

/**
 * Computes the distance between motors based on the diagonal size of a tiny-whoop frame
 * @param String whoopType - The type of tiny-whoop for which compute the size
 * @returns Number - The distance between motors
 */
function getWhoopMotorInterval(whoopType) =
    sqrt(pow(getWhoopData(whoopType, IDX_WHOOP_FRAME), 2) / 2)
;

/**
 * Gets the height of a tiny-whoop
 * @param String whoopType - The type of tiny-whoop
 * @returns Number - The height of the tiny-whoop
 */
function getWhoopHeight(whoopType) = layerAligned(
    getWhoopData(whoopType, IDX_WHOOP_HEIGHT)
);

/**
 * Gets the ground thickness
 * @param String boxType - The type of box
 * @returns Number - The ground thickness for the given box
 */
function getBoxGroundThickness(boxType) = layerAligned(
    getBoxData(boxType, IDX_BOX_GROUND)
);

/**
 * Gets the wall thickness
 * @param String boxType - The type of box
 * @returns Number - The wall thickness for the given box
 */
function getBoxWallThickness(boxType) = nozzleAligned(
    getBoxData(boxType, IDX_BOX_WALL)
);

/**
 * Gets the distance from the internal space to walls
 * @param String boxType - The type of box
 * @returns Number - The distance to walls for the given box
 */
function getBoxWallDistance(boxType) = printTolerance * getBoxData(boxType, IDX_BOX_DISTANCE);

/**
 * Gets the distance from the tiny-whoop ducts to walls
 * @param String boxType - The type of box
 * @returns Number - The distance to walls for the given box
 */
function getBoxWhoopDistance(boxType) =
    printTolerance * getBoxCumulativeData(boxType, IDX_BOX_DISTANCE) +
    vsum([
        for (type = pop(getBoxTypeList(boxType)))
            getBoxWallThickness(type)
    ])
;

/**
 * Gets the height of a box with respect to the given tiny-whoop
 * @param String boxType - The type of box
 * @param String whoopType - The type of tiny-whoop
 * @returns Number - The height of the box
 */
function getBoxHeight(boxType, whoopType) =
    getWhoopHeight(whoopType) +
    layerAligned(getBoxData(boxType, IDX_BOX_HEIGHT)) +
    vsum([
        for (type = getBoxTypeList(boxType))
            getBoxGroundThickness(type)
    ])
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
 * @returns Vector - The distance betwenn external ducts
 */
function getDuctDistance(interval, diameter, count = 1, wall = 0) =
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
 * @returns Vector - The distance betwenn external ducts
 */
function getDuctPoints(interval, diameter, count = 1, wall = 0) =
    let(
        point = getDuctDistance(interval, diameter, count, wall) / 2
    )
    [ for (i = [0:3])
        quadrant(point, i)
    ]
;
