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
 * Defines cupboard shapes.
 *
 * @author jsconan
 */

/**
 * Computes the points defining the polygon shape of a cupboard that will
 * contain drawers for several tiny-whoops.
 * @param Number duct - The duct diameter
 * @param Number interval - The distance between ducts
 * @param Number [wall] - The thickness of walls between each tiny-whoops
 * @param Number [offset] - The offset for the bottom side
 * @param Vector [count] - The number of whoops on each axis
 * @returns Vector[]
 */
function drawWhoopCupboardShape(duct, interval, wall=0, offset=0, count=1) =
    let(
        n = 8,
        count = vector2D(count),
        radius = getDuctRadius(n, duct),
        points = getDuctPoints(interval, duct, count, wall),
        offset = [0, offset]
    )
    [
        for (i = [0 : n  - 1])
            points[floor(i / 2)] + arcp(radius, getPolygonAngle(i + 0.5, n)) + [0, offset[floor(i / 4)]]
    ]
;

/**
 * Builds a cupboard that will contain drawers for several tiny-whoops.
 * @param Number motorDistance - The distance between motors on the diagonal
 * @param Number ductDiameter - The outer diameter of a motor duct
 * @param Number drawerWallThickness - The thickness of the internal walls
 * @param Number wallThickness - The thickness of the walls
 * @param Number drawerHeight - The height of a drawer
 * @param Number [wallDistance] - The distance between a duct and a drawer's wall
 * @param Number [drawerDistance] - The distance between a drawer and the wall
 * @param Number [drawerCount] - The number of drawers
 * @param Vector [whoopCount] - The number of tiny-whoops on each axis
 */
module whoopCupboard(motorDistance, ductDiameter, drawerWallThickness, wallThickness, drawerHeight, wallDistance=0, drawerDistance=0, drawerCount=1, whoopCount=1) {
    duct = ductDiameter + wallDistance * 2;
    interval = getMotorInterval(motorDistance);
    cupboardWidth = getDuctDistance(interval, duct, whoopCount, drawerWallThickness)[0] + duct + (drawerWallThickness + drawerDistance + wallThickness) * 2;
    fullHeight = (drawerHeight + wallThickness) * drawerCount + wallThickness;

    rotateX(270) {
        translate(-[0, cupboardWidth, fullHeight] / 2) {
            difference() {
                extrudePolygon(points=drawWhoopCupboardShape(
                    duct = duct,
                    interval = interval,
                    wall = drawerWallThickness,
                    offset = drawerDistance + wallThickness,
                    count = whoopCount
                ), height=fullHeight, distance=drawerWallThickness + drawerDistance + wallThickness);

                translateZ(wallThickness) {
                    repeat(count=drawerCount, interval = [0, 0, drawerHeight + wallThickness]) {
                        extrudePolygon(points=drawWhoopCupboardShape(
                            duct = duct,
                            interval = interval,
                            wall = drawerWallThickness,
                            offset = -wallThickness,
                            count = whoopCount
                        ), height=drawerHeight, distance=drawerWallThickness + drawerDistance);
                    }
                }
            }
        }
    }
}
