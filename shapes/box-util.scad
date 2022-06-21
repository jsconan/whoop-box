/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2019 Jean-Sebastien CONAN
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
 * Defines box util shapes.
 *
 * @author jsconan
 * @version 0.1.0
 */

/**
 * Draws the shape of a box handle indentation.
 * @param Vector size - The size of the box
 * @param Vector indentation - The size of the indentation
 */
module boxIndentationShape(size, indentation) {
    size = vector3D(size);
    indentation = vector2D(indentation);
    translateZ(size[2] - indentation[1] / 2) {
        simplePolyhedron(
            bottom = drawCross(vadd(size, ALIGN2), indentation[1]),
            top = drawCross(vadd(size, ALIGN2), indentation[0]),
            z = indentation[1]
        );
    }
}

/**
 * Draws the shape of a box handle holes.
 * @param Vector size - The size of the box
 * @param Vector hole - The size of the hole
 */
module boxHoleShape(size, hole) {
    size = vector3D(size);
    hole = vector2D(hole);

    translateZ(size[2] / 2) {
        rotateY(90) {
            shaft(d=flip(hole), h=size[0] + ALIGN2, center=true);
        }
        rotateX(90) {
            shaft(d=hole, h=size[1] + ALIGN2, center=true);
        }
    }
}

/**
 * Builds a box shape, with the cut for the handle (indentation).
 * @param Vector size - The size of the box
 * @param Number ground - The thickness of the box floor
 * @param Vector [count] - The number of tiny-whoops on each axis
 */
module boxShape(size, ground, count = 1) {
    difference() {
        children(0);
        translateZ(ground) {
            children(1);
        }
        repeatShape2D(size, count, center=true) {
            boxIndentationShape(size, boxIndentation);
        }
    }
}

/**
 * Extrudes a shape polygon, taking care of the outline.
 * @param Vector[] points - The points that define the shape
 * @param Number height - The height of the shape
 * @param Number [distance] - The distance to the shape's outline
 */
module extrudeShape(points, height, distance = 0) {
    linear_extrude(height=height, convexity=10) {
        polygon(distance ? outline(points=points, distance=distance) : points);
    }
}
