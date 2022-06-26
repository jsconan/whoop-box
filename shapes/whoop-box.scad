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
 * A box to store tiny-whoops.
 *
 * Defines the shapes for a simple box to store a tiny-whoop.
 *
 * @author jsconan
 */

/**
 * Computes the points defining the outline of a tiny-whoop box.
 * @param Number motorDistance - The distance between motors on the diagonal.
 * @param Number ductDiameter - The outer diameter of a motor duct.
 * @returns Vector[]
 */
function drawWhoopBox(motorDistance, ductDiameter) =
    let(
        radius = float(ductDiameter) / 2,
        interval = ceil(getMotorInterval(motorDistance)),
        points = getDuctPoints(interval, ductDiameter)
    )
    concat(
        arc(r=radius, o=points[0], a1=0,   a2=90),
        arc(r=radius, o=points[1], a1=90,  a2=180),
        arc(r=radius, o=points[2], a1=180, a2=270),
        arc(r=radius, o=points[3], a1=270, a2=360)
    )
;

/**
 * Computes the points defining the outline of a tiny-whoop inside the box.
 * @param Number motorDistance - The distance between motors on the diagonal.
 * @param Number ductDiameter - The outer diameter of a motor duct.
 * @returns Vector[]
 */
function drawWhoopOutline(motorDistance, ductDiameter) =
    let(
        radius = float(ductDiameter) / 2,
        interval = getMotorInterval(motorDistance),
        points = getDuctPoints(interval, ductDiameter),
        angle = getPolygonAngle(1, 12),
        motor = interval / 2,
        middle = motor + radius * sin(angle * 5) * 3 / 4,
        top = motor + radius * sin(angle * 4)
    )
    concat(
        arc(r=radius, o=points[0], a1=-2.0*angle, a2=3.5*angle), [[0,       top]],
        arc(r=radius, o=points[1], a1= 2.5*angle, a2=8.0*angle), [[-middle, 0]],
        arc(r=radius, o=points[2], a1= 4.0*angle, a2=9.5*angle), [[0,       -top]],
        arc(r=radius, o=points[3], a1=-3.5*angle, a2=2.0*angle), [[middle,  0]]
    )
;

/**
 * Builds a box that will contain a tiny-whoop.
 * @param Number motorDistance - The distance between motors on the diagonal.
 * @param Number ductDiameter - The outer diameter of a motor duct.
 * @param Number wallThickness - The thickness of the walls.
 * @param Number groundThickness - The thickness of the ground.
 * @param Number boxHeight - The height of the box.
 * @param Number paddingWidth - The width of the padding between the box sides and the tiny-whoop.
 * @param Number paddingHeight - The height of the padding between the box sides and the tiny-whoop.
 * @param Number wallDistance - The distance between a duct and the wall.
 */
module whoopBox(motorDistance, ductDiameter, wallThickness, groundThickness, boxHeight, paddingWidth, paddingHeight, wallDistance) {
    boxWidth = getBoxWidth(motorDistance=motorDistance, ductDiameter=ductDiameter, wallThickness=wallThickness, wallDistance=paddingWidth);
    outerPoints = outline(points=drawWhoopBox(motorDistance=motorDistance, ductDiameter=ductDiameter), distance=paddingWidth);
    innerPoints = outline(points=drawWhoopOutline(motorDistance=motorDistance, ductDiameter=ductDiameter), distance=wallDistance);

    boxIndentation(size=apply3D(boxWidth, z=boxHeight), indentation=boxIndentation, count=1) {
        extrudePolygonBox(points=outerPoints, height=boxHeight, ground=groundThickness, wall=wallThickness);
    }

    translateZ(groundThickness) {
        negativeExtrude(height=paddingHeight) {
            difference() {
                polygon(points=outerPoints);
                polygon(points=innerPoints);
            }
        }
    }
}

/**
 * Builds a container that will contain tiny-whoop boxes.
 * @param Number motorDistance - The distance between motors on the diagonal.
 * @param Number ductDiameter - The outer diameter of a motor duct.
 * @param Number wallThickness - The thickness of the walls.
 * @param Number containerThickness - The thickness of the container walls.
 * @param Number boxHeight - The height of the box.
 * @param Number paddingWidth - The width of the padding between the box sides and the tiny-whoop.
 * @param Number wallDistance - The distance between a box and the container wall.
 * @param Number|Vector [cells] - The number of boxes per container. It gives the number on the horizontal and vertical axis.
 */
module whoopBoxContainer(motorDistance, ductDiameter, wallThickness, containerThickness, boxHeight, paddingWidth, wallDistance, cells=[1, 1]) {
    cells = vector2D(cells);
    innerDistance = paddingWidth + wallThickness + wallDistance;
    innerPoints = outline(points=drawWhoopBox(motorDistance=motorDistance, ductDiameter=ductDiameter), distance=innerDistance);
    innerWidth = getBoxWidth(motorDistance=motorDistance, ductDiameter=ductDiameter, wallThickness=0, wallDistance=innerDistance);
    innerHeight = boxHeight + wallDistance * 2;

    containerWidth = innerWidth + containerThickness;
    containerLength = (innerWidth + containerThickness) * cells.x + containerThickness;
    containerHeight = (innerHeight + containerThickness) * cells.y + containerThickness;
    containerOffset = ductDiameter / 2 + innerDistance;

    outerPoints = outline(points=drawWhoopBox(motorDistance=motorDistance, ductDiameter=ductDiameter), distance=innerDistance + containerThickness);
    outerWidth = innerWidth + containerThickness * 2;;
    outerHeight = innerHeight + containerThickness * 2;

    difference() {
        union() {
            translateZ(-outerWidth / 2) {
                box([containerLength / 3, containerHeight, containerWidth / 2]);
            }
            repeatShape2D([outerWidth - containerThickness, outerHeight - containerThickness], cells, center=true) {
                rotateX(90) {
                    extrudePolygon(points=outerPoints, height=outerHeight, center=true);
                }
            }
        }
        translateZ(containerThickness / 2) {
            repeatShape2D(vadd([innerWidth, innerHeight], containerThickness), cells, center=true) {
                box([innerWidth, innerHeight, innerWidth]);
                rotateX(90) {
                    extrudePolygon(points=innerPoints, height=innerHeight, center=true);
                }
            }
        }
        translateZ(containerWidth / 2 - containerOffset + 1) {
            repeatShape2D([outerWidth - containerThickness, outerHeight - containerThickness], [1, cells.y], center=true) {
                box([containerLength + 1, innerHeight, containerOffset + 1]);
            }
        }
    }
}