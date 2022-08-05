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
 * Defines drawer shapes.
 *
 * @author jsconan
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
function drawAngledDrawerShape(duct, interval, wall=0, count=1) =
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
 * @param Number motorDistance - The distance between motors on the diagonal
 * @param Number ductDiameter - The outer diameter of a motor duct
 * @param Number wallThickness - The thickness of the walls
 * @param Number groundThickness - The thickness of the ground
 * @param Number boxHeight - The height of the box
 * @param Number [wallDistance] - The distance between a duct and the wall
 * @param Vector [whoopCount] - The number of tiny-whoops on each axis
 */
module angledDrawer(motorDistance, ductDiameter, wallThickness, groundThickness, boxHeight, wallDistance=0, whoopCount=1) {
    duct = ductDiameter + wallDistance * 2;
    interval = getMotorInterval(motorDistance);
    boxWidth = interval + duct + wallThickness * 2;
    innerWidth = boxWidth - wallThickness;

    boxShape(size=apply3D(boxWidth, z=boxHeight), ground=groundThickness, count=whoopCount) {
        extrudePolygon(points=drawAngledDrawerShape(
            duct = duct,
            interval = interval,
            wall = wallThickness,
            count = whoopCount
        ), height=boxHeight, distance=wallThickness);

        repeatShape2D(innerWidth, whoopCount, center=true) {
            extrudePolygon(points=drawAngledDrawerShape(
                duct = duct,
                interval = interval
            ), height=boxHeight);
        }
    }
}
