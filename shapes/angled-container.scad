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
 * Defines box container shapes.
 *
 * @author jsconan
 */

/**
 * Computes the points defining the polygon shape of a box that will
 * contain several tiny-whoops.
 * @param Number duct - The duct diameter
 * @param Number interval - The distance between ducts
 * @param Number [wall] - The thickness of walls between each tiny-whoops
 * @param Vector [count] - The number of whoops on each axis
 * @returns Vector[]
 */
function drawAngledContainerShape(duct, interval, wall=0, count=1) =
    let(
        n = 8,
        angle = getPolygonAngle(1, n),
        radius = getDuctRadius(n, duct),
        count = vector2D(count),
        width = interval + duct + wall,
        stepX = [width, 0],
        stepY = [0, width],
        point = width * (count - [1, 1]) / 2,
        points = [ for (i = [0:3]) quadrant(point, i) ],
        ducts = [ for (i = [0:3]) quadrant(interval, i) / 2 ],
        length = count * 4 - [2, 2]
    )
    concat(
        // point 1
        [
            for (c = [1 : length[0]])
                let(
                    i = floor(c / 4),
                    j = c % 4
                )
                points[0] - stepX * i + ducts[floor(j / 2) % 4] + arcp(radius, angle * (j + 0.5))
        ],
        // point 2
        [
            for (c = [1 : length[1]])
                let(
                    i = floor(c / 4),
                    j = c % 4
                )
                points[1] - stepY * i + ducts[floor((2 + j) / 2) % 4] + arcp(radius, angle * (j + 2.5))
        ],
        // point 3
        [
            for (c = [1 : length[0]])
                let(
                    i = floor(c / 4),
                    j = c % 4
                )
                points[2] + stepX * i + ducts[floor((4 + j) / 2) % 4] + arcp(radius, angle * (j + 4.5))
        ],
        // point 4
        [
            for (c = [1 : length[1]])
                let(
                    i = floor(c / 4),
                    j = c % 4
                )
                points[3] + stepY * i + ducts[floor((6 + j) / 2) % 4] + arcp(radius, angle * (j + 6.5))
        ]
    )
;

/**
 * Builds a box that will contain several tiny-whoops.
 * @param Number motorDistance - The distance between motors on the diagonal
 * @param Number ductDiameter - The outer diameter of a motor duct
 * @param Number wallThickness - The thickness of the walls
 * @param Number groundThickness - The thickness of the ground
 * @param Number boxHeight - The height of the box
 * @param Number [wallDistance] - The distance between a duct and the wall
 * @param Vector [whoopCount] - The number of tiny-whoops on each axis
 */
module angledContainer(motorDistance, ductDiameter, wallThickness, groundThickness, boxHeight, wallDistance=0, whoopCount=1) {
    duct = ductDiameter + wallDistance * 2;
    interval = getMotorInterval(motorDistance);
    boxWidth = interval + duct + wallThickness * 2;
    innerWidth = boxWidth - wallThickness;

    boxShape(size=apply3D(boxWidth, z=boxHeight), ground=groundThickness, count=whoopCount) {
        extrudePolygon(points=drawAngledContainerShape(
            duct = duct,
            interval = interval,
            wall = wallThickness,
            count = whoopCount
        ), height=boxHeight, distance=wallThickness);

        repeatShape2D(innerWidth, whoopCount, center=true) {
            extrudePolygon(points=drawAngledContainerShape(
                duct = duct,
                interval = interval
            ), height=boxHeight);
        }
    }
}
