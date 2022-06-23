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
 * Global configuration.
 *
 * @author jsconan
 */

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the characteristics of the printer
layerHeight = 0.2;      // The height of the printed layers
nozzleWidth = 0.4;      // The size of the printer's nozzle
printTolerance = 0.1;   // The print tolerance when pieces need to be assembled
printInterval = 5;      // The interval between 2 pieces when presented together
printerLength = 250;    // The length of the printer's build plate
printerWidth = 210;     // The width of the printer's build plate

// Defines the size of a box indentation
boxIndentation = [30, 10];

// Defines the size of a handle hole
boxHandleHole = 20;

// Defines the target tiny-whoop type
whoopType = TINY_WHOOP_65_BL;

// Sets the count of tiny-whoops in each kind of box
whoopCountBox = 2;
whoopCountDrawer = 2;
drawerCountCupboard = 2;
