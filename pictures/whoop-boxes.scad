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
 * Shows a complete box container.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../config/setup.scad>

// Setup the model
drawers = [whoopBoxX, whoopBoxY];
drawersCount = drawers.x * drawers.y;
drawerWidth = getBoxWidth(motorDistance=motorDistance, ductDiameter=ductDiameter, wallThickness=wallThickness, wallDistance=boxPadding);
drawerHeight = getBoxHeight(whoopHeight=whoopHeight, groundThickness=groundThickness);
drawerSpace = outerDistance + containerThickness;
drawerIntervalX = drawerWidth + drawerSpace;
drawerIntervalY = drawerIntervalX;
drawerIntervalZ = drawerHeight + drawerSpace;
drawerLeft = -drawerIntervalX * (drawers.x - 1) / 2;
drawerBottom = -drawerIntervalZ * drawers.y / 2 + drawerSpace;

// Setup the animation steps
rotationSteps = 20;
translationSteps = 5;
steps = rotationSteps + translationSteps * drawersCount * 2;
rotationEnd = rotationSteps / steps;
translationEnd = translationSteps / steps * 2;
drawerClosed = [0, 0, 0];
drawerOpen = [0, -drawerWidth / 2, 0];

viewportFront = [55, 0, 31];
viewportUp = [27, 0, 37];
viewportRange = interpolationRange3D(values=[
    viewportFront,
    viewportUp,
    viewportFront
], start=rotationEnd, end=1);

// Setup the viewport
$vpr = interpolateStep3D(step=$t, range=viewportRange);
$vpt = [0, -20, 0.75];
$vpd = 450;

// Show the number of steps for all animations
if (showSteps) {
    echo(steps);
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    rotate(interpolateStep(step=$t, low=0, high=360, start=0, end=rotationEnd)) {
        translateZ(wallThickness) {
            rotateX(90) {
                color(colorWhoopBoxContainer) {
                    whoopBoxContainer(
                        motorDistance = motorDistance,
                        ductDiameter = ductDiameter,
                        wallThickness = wallThickness,
                        containerThickness = containerThickness,
                        linkThickness = linkThickness,
                        boxHeight = drawerHeight,
                        paddingWidth = boxPadding,
                        wallDistance = outerDistance,
                        cells = drawers
                    );
                }
            }
        }
        translate([drawerLeft, 0, drawerBottom]) {
            for(x = [0 : drawers.x - 1]) {
                for(z = [0 : drawers.y - 1]) {
                    i = z * drawers.x + x;
                    start = rotationEnd + i * translationEnd;
                    end = start + translationEnd;
                    drawerPosition = [x * drawerIntervalX, 0, z * drawerIntervalZ];
                    drawerRange = interpolationRange3D(values=[
                        drawerPosition + drawerClosed,
                        drawerPosition + drawerOpen,
                        drawerPosition + drawerClosed
                    ], start=start, end=end);

                    translate(interpolateStep3D(step=$t, range=drawerRange)) {
                        color(colorWhoopBox) {
                            whoopBox(
                                motorDistance = motorDistance,
                                ductDiameter = ductDiameter,
                                wallThickness = wallThickness,
                                groundThickness = groundThickness,
                                boxHeight = drawerHeight,
                                paddingWidth = boxPadding,
                                paddingHeight = ductHeight,
                                wallDistance = getWallDistance(wallThickness=wallThickness),
                                separator = boxSeparators
                            );
                        }
                    }
                }
            }
        }
    }
}
