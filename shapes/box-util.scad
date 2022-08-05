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
 * Defines utility shapes and operators.
 *
 * @author jsconan
 */

/**
 * Removes the handle indentation from the children.
 * The indentation will be cut from each box side.
 * @param Vector size - The size of the box.
 * @param Vector indentation - The size of the indentation.
 *                             The first value represents the top width,
 *                             the second represents the bottom width and the depth.
 * @param Vector [count] - The number of boxes on each axis.
 */
module boxIndentation(size, indentation, count=1) {
    size = vector3D(size);
    indentation = vector2D(indentation);

    difference() {
        children();
        translateZ(size.z - indentation[1] / 2) {
            repeatShape2D(size, count, center=true) {
                simplePolyhedron(
                    bottom = drawCross(vadd(size, ALIGN2), indentation[1]),
                    top = drawCross(vadd(size, ALIGN2), indentation[0]),
                    z = indentation[1]
                );
            }
        }
    }
}

/**
 * Removes the handle indentation from the children.
 * The indentation will be cut from each box side.
 * @param Vector size - The size of the box.
 * @param Vector indentation - The size of the indentation.
 *                             The first value represents the top width,
 *                             the second represents the bottom width and the depth.
 */
module simpleIndentation(size, indentation) {
    size = vector3D(size);
    indentation = vector2D(indentation);

    difference() {
        children();
        translateZ(size.z - indentation[1] / 2) {
            translateX(-size.x / 2) {
                repeatRotate(count=4, origin=[size.x / 2, 0, 0]) {
                    simplePolyhedron(
                        bottom = drawRectangle(indentation[1] + ALIGN2),
                        top = drawRectangle(indentation[0] + ALIGN2),
                        z = indentation[1]
                    );
                }
            }
        }
    }
}

/**
 * Builds a box shape, with the cut for the handle indentation.
 * @param Vector size - The size of the box.
 * @param Number ground - The thickness of the box floor.
 * @param Vector [count] - The number of boxes on each axis.
 */
module boxShape(size, ground, count=1) {
    boxIndentation(size=size, indentation=boxIndentation, count=count) {
        difference() {
            children(0);
            translateZ(ground) {
                children(1);
            }
        }
    }
}
