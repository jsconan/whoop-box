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
 * Defines drawer shapes.
 *
 * @author jsconan
 * @version 0.1.0
 */

/**
 * Computes the points defining the polygon shape of a drawer that will contain
 * several tiny-whoops.
 * @param Number duct - The duct diameter
 * @param Number interval - The distance between ducts
 * @param Number [wall] - The thickness of walls between each tiny-whoops
 * @param Vector [count] - The number of whoops on each axis
 * @returns Vector[]
 */
function drawWhoopDrawerShape(duct, interval, wall = 0, count = 1) =
    let(
        n = 8,
        count = vector2D(count),
        radius = getDuctRadius(n, duct),
        points = getDuctPoints(interval, duct, count, wall)
    )
    [
        for (i = [0 : n  - 1])
            points[floor(i / 2)] + arcp(radius, getPolygonAngle(i + 0.5, n))
    ]
;

/**
 * Builds a drawer that will contain several tiny-whoops.
 * @param String whoopType - The type of tiny-whoop
 * @param Number wallThickness - The thickness of the walls
 * @param Number groundThickness - The thickness of the ground
 * @param Number boxHeight - The height of the box
 * @param Number [ductDistance] - The distance between a duct and the wall
 * @param Vector [whoopCount] - The number of tiny-whoops on each axis
 */
module whoopDrawer(whoopType, wallThickness, groundThickness, boxHeight, ductDistance = 0, whoopCount = 1) {
    duct = getWhoopDuctDiameter(whoopType) + ductDistance * 2;
    interval = getWhoopMotorInterval(whoopType);
    boxWidth = interval + duct + wallThickness * 2;
    innerWidth = boxWidth - wallThickness;

    boxShape(size=apply3D(boxWidth, z=boxHeight), ground=groundThickness, count=whoopCount) {
        extrudeShape(points=drawWhoopDrawerShape(
            duct = duct,
            interval = interval,
            wall = wallThickness,
            count = whoopCount
        ), height=boxHeight, distance=wallThickness);

        repeatShape2D(innerWidth, whoopCount, center=true) {
            extrudeShape(points=drawWhoopDrawerShape(
                duct = duct,
                interval = interval
            ), height=boxHeight);
        }
    }
}
