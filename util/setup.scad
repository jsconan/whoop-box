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
 * A box to store a tiny whoop.
 *
 * Setup the context.
 *
 * @author jsconan
 * @version 0.1.0
 */

// As we need to use some shapes, use the right entry point of the library.
include <../lib/camelSCAD/shapes.scad>

// Then we need the config for the project, as well as the related functions
include <../config/config.scad>
include <functions.scad>

// Finally, include the shapes
include <../shapes/box-util.scad>
include <../shapes/rounded-box.scad>
include <../shapes/angled-box.scad>
include <../shapes/container.scad>
include <../shapes/drawer.scad>
include <../shapes/cupboard.scad>
