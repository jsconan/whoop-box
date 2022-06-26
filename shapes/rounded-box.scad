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
 * Defines rounded box shapes.
 *
 * @author jsconan
 */

/**
 * Computes the points defining a duct outline.
 * Rounded version.
 * @param Vector point - The center of the duct
 * @param Number duct - The duct diameter
 * @param Number start - The start sector
 * @param Number end - The end sector
 * @param Number n - The number of sectors
 * @returns Vector[]
 */
function drawRoundedBoxDuct(point, duct, start, end, n=12) =
    let(
        point = vector2D(point),
        radius = float(duct) / 2,
        angle = getPolygonAngle(1, n),
        start = float(start) * angle,
        end = float(end) * angle
    )
    arc(r=radius, o=point, a1=start, a2=end)
;

/**
 * Computes the points defining the polygon shape surrounding a tiny-whoop.
 * Rounded version.
 * @param Number motorDistance - The distance between motors on the diagonal.
 * @param Number ductDiameter - The outer diameter of a motor duct.
 * @returns Vector[]
 */
function drawRoundedBoxShape(motorDistance, ductDiameter) =
    let(
        n = 12,
        points = getDuctPoints(getMotorInterval(motorDistance), ductDiameter)
    )
    concat(
        drawRoundedBoxDuct(point=points[0], duct=ductDiameter, start=-1.5, end= 4.5, n=n),
        drawRoundedBoxDuct(point=points[1], duct=ductDiameter, start= 1.5, end= 7.5, n=n),
        drawRoundedBoxDuct(point=points[2], duct=ductDiameter, start= 4.5, end=10.0, n=n),
        drawRoundedBoxDuct(point=points[3], duct=ductDiameter, start=-4.0, end= 1.5, n=n)
    )
;

/**
 * Builds a box that will contain a tiny-whoop.
 * Rounded version.
 * @param Number motorDistance - The distance between motors on the diagonal
 * @param Number ductDiameter - The outer diameter of a motor duct
 * @param Number wallThickness - The thickness of the walls
 * @param Number groundThickness - The thickness of the ground
 * @param Number boxHeight - The height of the box
 * @param Number [wallDistance] - The distance between a duct and the wall
 */
module roundedBox(motorDistance, ductDiameter, wallThickness, groundThickness, boxHeight, wallDistance=0) {
    boxWidth = getBoxWidth(motorDistance=motorDistance, ductDiameter=ductDiameter, wallThickness=wallThickness, wallDistance=wallDistance);
    points = outline(points=drawRoundedBoxShape(motorDistance=motorDistance, ductDiameter=ductDiameter), distance=wallDistance);

    boxShape(size=apply3D(boxWidth, z=boxHeight), ground=groundThickness) {
        extrudePolygon(points=points, height=boxHeight, distance=wallThickness);
        extrudePolygon(points=points, height=boxHeight);
    }
}
