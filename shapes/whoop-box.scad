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
 * Computes the points defining the outline of a box cover.
 * @param Number length - The length of the box.
 * @param Number width - The width of the box.
 * @param Number radius - The radius of the rounded corner (related to the whoop ducts).
 * @returns Vector[]
 */
function drawBoxCover(length, width, radius) =
    let(
        side = width - radius,
        top = length - radius * 2
    )
    path([
        ["P", length / 2, 0],
        ["V", side],
        ["C", radius, 0, 90],
        ["H", -top],
        ["C", radius, 90, 180],
        ["V", -side],
    ]);
;

/**
 * Computes the points defining the outline of a box link.
 * @param Number width - The width of the link.
 * @param Number height - The height of the link.
 * @param Number [distance] - An additional distance added to the outline.
 * @returns Vector[]
 */
function drawBoxLink(width, height, distance) =
    let(
        neck = height / 6,
        slope = neck * 4,
        bottom = (width / 2) - slope
    )
    path([
        ["P", bottom, -distance],
        ["V", neck + distance],
        ["L", slope, slope],
        ["V", neck],
        ["H", -width],
        ["V", -neck],
        ["L", slope, -slope],
        ["V", -(neck + distance)]
    ])
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
 * @param Boolean [separator] - Tells whether the box contains separators or not.
 */
module whoopBox(motorDistance, ductDiameter, wallThickness, groundThickness, boxHeight, paddingWidth, paddingHeight, wallDistance, separator=false) {
    boxWidth = getBoxWidth(motorDistance=motorDistance, ductDiameter=ductDiameter, wallThickness=wallThickness, wallDistance=paddingWidth);
    outerPoints = outline(points=drawWhoopBox(motorDistance=motorDistance, ductDiameter=ductDiameter), distance=paddingWidth);
    innerPoints = outline(points=drawWhoopOutline(motorDistance=motorDistance, ductDiameter=ductDiameter), distance=wallDistance);

    boxIndentation(size=apply3D(boxWidth, z=boxHeight), indentation=boxIndentation, count=1) {
        extrudePolygonBox(points=outerPoints, height=boxHeight, ground=groundThickness, wall=wallThickness);
        if (paddingHeight > 0) {
            translateZ(groundThickness) {
                negativeExtrude(height=min(paddingHeight, boxHeight - groundThickness)) {
                    difference() {
                        polygon(points=outerPoints);
                        polygon(points=innerPoints);
                    }
                }
            }
        }
    }
    if (separator && paddingHeight == 0) {
        simpleIndentation(size=apply3D(boxWidth, z=boxHeight), indentation=boxIndentation) {
            box([boxWidth, wallThickness, boxHeight]);
            box([wallThickness, boxWidth, boxHeight]);
        }
    }
}

/**
 * Builds a container that will contain tiny-whoop boxes.
 * @param Number motorDistance - The distance between motors on the diagonal.
 * @param Number ductDiameter - The outer diameter of a motor duct.
 * @param Number wallThickness - The thickness of the walls.
 * @param Number containerThickness - The thickness of the container walls.
 * @param Number linkThickness - The thickness of the link elements.
 * @param Number boxHeight - The height of the box.
 * @param Number paddingWidth - The width of the padding between the box sides and the tiny-whoop.
 * @param Number wallDistance - The distance between a box and the container wall.
 * @param Number|Vector [cells] - The number of boxes per container. It gives the number on the horizontal and vertical axis.
 */
module whoopBoxContainer(motorDistance, ductDiameter, wallThickness, containerThickness, linkThickness, boxHeight, paddingWidth, wallDistance, cells=[1, 1]) {
    cells = vector2D(cells);
    innerDistance = paddingWidth + wallThickness + wallDistance / 2;
    innerWidth = getBoxWidth(motorDistance=motorDistance, ductDiameter=ductDiameter, wallThickness=0, wallDistance=innerDistance);
    innerHeight = boxHeight + wallDistance;
    innerRadius = ductDiameter / 2 + innerDistance;

    outerWidth = innerWidth + containerThickness * 2;;
    outerHeight = innerHeight + containerThickness * 2;
    outerRadius = innerRadius + containerThickness;

    linkWidth = outerWidth - outerRadius * 2;
    linkWidthTop = linkWidth - printTolerance * 2;
    linkWidthBottom = linkWidth + printTolerance * 2;
    linkHeight = linkThickness;

    containerWidth = innerWidth + containerThickness;
    containerLength = (innerWidth + containerThickness) * cells.x + containerThickness;
    containerHeight = (innerHeight + containerThickness) * cells.y + containerThickness + linkHeight;

    rotateX(-90) {
        difference() {
            translate([0, containerThickness, -linkHeight] / 2) {
                extrudePolygon(points=drawBoxCover(length=containerLength, width=containerWidth / 2, radius=outerRadius), height=containerHeight, center=true);
                repeatShape3D([outerWidth - containerThickness, containerWidth, containerHeight], [cells.x, 1, 1], center=true) {
                    rotateZ(180) {
                        extrudePolygon(points=drawBoxCover(length=outerWidth, width=containerWidth / 2, radius=outerRadius), height=containerHeight, center=true);
                    }
                    translateZ(containerHeight / 2) {
                        rotateX(90) {
                            extrudePolygon(points=drawBoxLink(width=linkWidthTop, height=linkHeight, distance=printTolerance), height=containerWidth, distance=-printTolerance, center=true);
                        }
                    }
                }
            }
            repeatShape3D(vadd([innerWidth, innerWidth, innerHeight], containerThickness), [cells.x, 1, cells.y], center=true) {
                translateY(-innerWidth / 2) {
                    extrudePolygon(points=drawBoxCover(length=innerWidth, width=innerWidth, radius=innerRadius), height=innerHeight, center=true);
                }
                translate([0, outerRadius - outerWidth - 1, -innerHeight] / 2) {
                    box([outerWidth + 1, outerRadius + 1, innerHeight]);
                }
            }
            repeatShape3D([outerWidth - containerThickness, containerWidth, containerHeight], [cells.x, 1, 1], center=true) {
                translate([0, containerThickness, -(linkHeight + containerHeight)] / 2) {
                    rotateX(90) {
                        extrudePolygon(points=drawBoxLink(width=linkWidthBottom, height=linkHeight, distance=1), height=containerWidth + 1, distance=printTolerance, center=true);
                    }
                }
            }
        }
    }
}
