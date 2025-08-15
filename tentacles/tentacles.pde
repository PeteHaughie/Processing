/**
 * Flesh and Bone.
 * draws weird tentacles and bare bones.
 * 
 * Processing 3.5.3
 * @author @deconbatch
 * @version 0.1
 * created 0.1 2020.03.15
 */

void setup() {
  size(980, 980, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  rectMode(CENTER);
  smooth(8);
  noLoop();
}

void draw() {
  int   frmMax     = 3; // draws three images
  float baseHue    = random(360);
  float baseRadius = min(width, height) / 6.0;
  translate(width * 0.5, height * 0.5);
  for (int frmCnt = 0; frmCnt < frmMax; frmCnt++) {
    float rndRotate = random(PI);
    noiseSeed(floor(baseHue + rndRotate));
    // draw background
    blendMode(BLEND);
    baseHue += 60.0;
    drawCanvas(baseHue);
    pushMatrix();
    rotate(rndRotate);
    // calculate tentacles and draw
    ArrayList<PVector> pvs = calcTentacles(baseHue, baseRadius);
    // draw bones
    baseHue += 60.0;
    drawBones(baseHue, baseRadius, pvs);
    popMatrix();  
    // draw casing
    blendMode(BLEND);
    casing();
    saveFrame("frames/" + String.format("%04d", frmCnt + 1) + ".png");
  }
  exit();
}

/**
 * calcTentacles : calculate tentacle shapes and draw with ellipse.
 *                 it may not good to do a calculation and drawing in one function. but it convenient.
 * @param  _baseHue    : shape's base color.
 * @param  _baseRadius : shape's whole size.
 * @return calculated main tentacle's coodinates as ArrayList<PVector>.
 */
ArrayList calcTentacles(float _baseHue, float _baseRadius) {
  ArrayList<PVector> pvs = new ArrayList<PVector>();
  float pDiv = random(0.018, 0.05); // it determines the shape. increment value in recurrence formula
  int   tMax = 200;  // how many tentacles
  int   lMax = 50;   // tentacle's length
  for (int tCnt = 0; tCnt < tMax; tCnt++) {
    // calculation parameters
    float djA = random(-TWO_PI, TWO_PI);
    float djB = random(-TWO_PI, TWO_PI);
    float djC = random(-TWO_PI, TWO_PI);
    float djD = random(-TWO_PI, TWO_PI);
    // grow tentacles in all directions
    float dR = map(tCnt, 0, tMax, 0.0, TWO_PI);
    float prevX   = 0.0;
    float prevY   = 0.0;
    float currX   = 0.0;
    float currY   = 0.0;
    float bX      = 0.0;
    float bY      = 0.0;
    float tLength = 0.0;
    ArrayList<PVector> tempArray = new ArrayList<PVector>();
    noStroke();
    for (int lCnt = 0; lCnt < lMax; lCnt++) {
      // it's not the De Jong attractor
      currX += pDiv * (sin(djA * prevY) - cos(djB * prevX));
      currY += pDiv * (sin(djC * prevX) - cos(djD * prevY));
      // rotational transfer
      float tX = currX * cos(dR) - currY * sin(dR);
      float tY = currY * cos(dR) + currX * sin(dR);
      tempArray.add(new PVector(tX, tY));
      prevX = currX;
      prevY = currY;
      // draw tentacle with ellipse
      float pSiz = dist(bX, bY, tX, tY) * _baseRadius * 2.0;
      float pHue = _baseHue + dist(tX, tY, 0.0, 0.0) * noise(tX * 0.1, tY * 0.1) * 90.0;
      fill(
           pHue % 360.0,
           map(noise(10.0, tX, tY), 0.0, 1.0, 0.0, 90.0),
           map(noise(20.0, tX, tY), 0.0, 1.0, 20.0, 90.0),
           100.0
      );
      ellipse(
              _baseRadius * tX,
              _baseRadius * tY,
              pSiz,
              pSiz
      );
      tLength += dist(bX, bY, tX, tY);
      bX = tX;
      bY = tY;
    }
    // long tentacles will pass this test
    if (tLength > pDiv * 50.0) {
      pvs.addAll(tempArray);
    } 
  }
  return pvs;
}

/**
 * drawBones : draws bones with line.
 * @param  _baseHue    : drawing base color.
 * @param  _baseRadius : shape's whole size.
 * @param  _pvs        : calculated coodinates.
 */
void drawBones(float _baseHue, float _baseRadius, ArrayList<PVector> _pvs) {
  noFill();
  for (PVector ppv : _pvs) {
    float pDist = dist(ppv.x, ppv.y, 0.0, 0.0);
    for (PVector fpv : _pvs) {
      float distance = dist(ppv.x, ppv.y, fpv.x, fpv.y);
      if (distance > 0.1 && distance < 0.2) {
        float lHue = _baseHue + pDist * noise(ppv.x * 0.1, ppv.y * 0.1) * 90.0;
        float lWgt = constrain(map(pDist, 0.0, 3.0, 5.0, 3.0), 3.0, 5.0);
        blendMode(MULTIPLY);
        strokeWeight(lWgt);
        stroke(
               lHue % 360.0,
               map(noise(10.0, fpv.x, fpv.y), 0.0, 1.0, 0.0, 90.0),
               map(noise(20.0, ppv.x, ppv.y), 0.0, 1.0, 80.0, 90.0),
               100.0
        );
        line(
             _baseRadius * ppv.x,
             _baseRadius * ppv.y,
             _baseRadius * fpv.x,
             _baseRadius * fpv.y
        );
        blendMode(ADD);
        strokeWeight(lWgt * 0.25);
        line(
             _baseRadius * ppv.x,
             _baseRadius * ppv.y,
             _baseRadius * fpv.x,
             _baseRadius * fpv.y
         );
      }
    }
  }
}

/**
 * casing : draw fancy casing
 */
private void casing() {
  fill(0.0, 0.0, 0.0, 0.0);
  strokeWeight(40.0);
  stroke(0.0, 0.0, 0.0, 100.0);
  rect(0.0, 0.0, width, height);
  strokeWeight(30.0);
  stroke(0.0, 0.0, 90.0, 100.0);
  rect(0.0, 0.0, width, height);
}

/**
 * drawCanvas : draw rough textured background
 * @param  _baseHue    : drawing base color.
 */
void drawCanvas(float _baseHue) {
  background((_baseHue + 30.0) % 360.0, 0.0, 90.0, 100.0);
  for (int x = 1; x < width * 0.5; x += 2) {
    for (int y = 1; y < height * 0.5; y += 2) {
  
      float pSize = random(0.5, 2.0);
      float pDiv  = random(-2.0, 2.0);
      float pSat = 0.0;
      if ((x + y) % 3 == 0) {
        pSat = 40.0;
      }
      strokeWeight(pSize);
      stroke(_baseHue, pSat, 50.0, 20.0);
      point(x + pDiv, y + pDiv);
      point(-x + pDiv, y + pDiv);
      point(x + pDiv, -y + pDiv);
      point(-x + pDiv, -y + pDiv);
    }
  }
}

/*
Copyright (C) 2021- deconbatch

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>
*/
