int sceneIndex = 0;

PImage LC, LM, LY, LK;
int maxnumFlower = 100;
int scaleFactor = 1;
PVector v1, v2, v3, v4;
int f = 20;
boolean moveOK = false;
int startFrame;

void settings() {
  LC = loadImage("LC.png");
  LM = loadImage("LM.png");
  LY = loadImage("LY.png");
  LK = loadImage("LK.png");
  size(LC.width, LC.height);
}

void setup(){
  startFrame = 0;
}

void draw(){
  v1 = new PVector(-5, 5);
  v2 = new PVector(0, -5);
  v3 = new PVector(0, 5);
  v4 = new PVector(0, 0);
  
  switch(sceneIndex) {
    case 0:
      drawScene1();
      break;
    case 1:
      drawScene2();
      break;
    case 2:
      drawScene3();
      break;
    case 3:
      drawScene4();
      break;
  }
}

void mousePressed(){
  if (sceneIndex < 4) {
    sceneIndex++;
  } else {
    sceneIndex = 0;
  }
  print(sceneIndex);
}

void drawScene1() {
  background(#f1f1f1);
  drawImage(LM, color(0, 167, 244), v2);
  noStroke();
 
}

void drawScene2() {
  drawImage(LY, color(236, 0, 180), v3);
  noStroke();
}

void drawScene3() {
  background(#f1f1f1);
  drawImage(LC, color(255, 0, 0), v1);
  noStroke();
  
}

void drawScene4(){
  background(#f1f1f1);
  drawImage(LK, color(0), v4);
  noStroke();
}

void drawImage(PImage theImage, color theColor, PVector offset) {
  theImage.loadPixels();
  fill(theColor);
  blendMode(MULTIPLY);

  int numFlower = 100;
  if (numFlower == 0) return;

  numFlower = constrain(numFlower, 1, maxnumFlower);

  float ratio = numFlower / maxnumFlower;
  ratio = pow(ratio, 0.125);
  float stepSize = map(ratio, 0, 1, 400, 10);
  stepSize = round(stepSize);

  float tile = theImage.width;
  float tW = width / tile;
  float tH = height / tile;
  float w = 0;
  float low = 0 ;

  for (int y = 0; y < theImage.height; y += stepSize) {
    for (int x = 0; x < theImage.width; x += stepSize) {
      int i = y * theImage.width + x;
      updatePixels();

      float darkness = (255 - blue(theImage.pixels[i])) / 255;
      float radius = stepSize * darkness * scaleFactor;

      PVector pos = new PVector(x, y).add(offset);

      w = map(tan(radians(frameCount * 0.4 + y * 0.01)), -1, 1, -tH, tH);
      if(w < low) low = w;

        int currentFrame = frameCount - startFrame; // Calculate the current frame relative to startFrame
        pushMatrix();
        translate(pos.x+tW/2, pos.y+tH/2 );
        rotate(radians(currentFrame / 2 + x * 5 + y * 10)); // Use currentFrame instead of frameCount
        pushMatrix();
        translate(0, w);
        strokeWeight(tW);
        noStroke();
        ellipse(0, 0, radius, radius);
        popMatrix();
        popMatrix();
      }
    }
    if(w <= -4226420){
       if(sceneIndex < 4){
          sceneIndex++;
        } else {
          sceneIndex = 0;
        }
        print(sceneIndex);
    }
  } 
