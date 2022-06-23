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
 * Defines angled box shapes.
 *
 * @author jsconan
 */

/**
 * Computes the points defining a duct outline.
 * Angled version.
 * @param Vector point - The center of the duct
 * @param Number duct - The duct diameter
 * @param Number start - The start sector
 * @param Number end - The end sector
 * @param Number m - The number of sectors for the intermediate points
 * @param Number n - The number of sectors for the surrounding points
 * @returns Vector[]
 */
function drawWhoopAngledBoxDuct(point, duct, start, end, m = 8, n = 12) =
    let(
        point = vector2D(point),
        angleM = getPolygonAngle(1, m),
        angleN = getPolygonAngle(1, n),
        radiusM = getDuctRadius(m, duct),
        radiusN = getDuctRadius(n, duct),
        start = float(start),
        end = float(end),
        startInternal = round(start * m / n),
        endInternal = round(end * m / n) - 1
    )
    concat([
        point + arcp(radiusN, start * angleN)
    ], [
        for (i = [startInternal : endInternal])
            point + arcp(radiusM, (i + 0.5) * angleM)
    ], [
        point + arcp(radiusN, end * angleN)
    ])
;

/**
 * Computes the points defining the polygon shape surrounding a tiny-whoop.
 * Angled version.
 * @param Number duct - The duct diameter
 * @param Number interval - The distance between ducts
 * @returns Vector[]
 */
function drawWhoopAngledBoxShape(duct, interval) =
    let(
        m = 8,
        n = 12,
        points = getDuctPoints(interval, duct)
    )
    concat(
        drawWhoopAngledBoxDuct(point=points[0], duct=duct, start=10.5, end=16.5, m=m, n=n),
        drawWhoopAngledBoxDuct(point=points[1], duct=duct, start= 1.5, end= 7.5, m=m, n=n),
        drawWhoopAngledBoxDuct(point=points[2], duct=duct, start= 4.5, end=10.0, m=m, n=n),
        drawWhoopAngledBoxDuct(point=points[3], duct=duct, start= 8.0, end=13.5, m=m, n=n)
    )
;

/**
 * Builds a box that will contain a tiny-whoop.
 * Angled version.
 * @param Number motorDistance - The distance between motors on the diagonal
 * @param Number ductDiameter - The outer diameter of a motor duct
 * @param Number wallThickness - The thickness of the walls
 * @param Number groundThickness - The thickness of the ground
 * @param Number boxHeight - The height of the box
 * @param Number [ductDistance] - The distance between a duct and the wall
 */
module whoopAngledBox(motorDistance, ductDiameter, wallThickness, groundThickness, boxHeight, ductDistance = 0) {
    duct = ductDiameter + ductDistance * 2;
    interval = getMotorInterval(motorDistance);
    boxWidth = interval + duct + wallThickness * 2;
    points = drawWhoopAngledBoxShape(duct=duct, interval=interval);

    boxShape(size=apply3D(boxWidth, z=boxHeight), ground=groundThickness) {
        extrudeShape(points=points, height=boxHeight, distance=wallThickness);
        extrudeShape(points=points, height=boxHeight);
    }
}
