// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for this video: https://youtu.be/BV9ny785UNc

// Written entirely based on
// http://www.karlsims.com/rd.html

// Also, for reference
// http://hg.postspectacular.com/toxiclibs/src/44d9932dbc9f9c69a170643e2d459f449562b750/src.sim/toxi/sim/grayscott/GrayScott.java?at=default

PGraphics feedPattern;
PImage victoria;

Cell[][] grid;
Cell[][] prev;

void setup() {
  size(100, 100);
  grid = new Cell[width][height];
  prev = new Cell[width][height];

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y ++) {
      float a = 1;
      float b = 0;
      grid[x][y] = new Cell(a, b);
      prev[x][y] = new Cell(a, b);
    }
  }
  
  victoria = loadImage("victoria.jpeg");
  
  ResizeImage(victoria);
  
  feedPattern = createGraphics(width, height);
  feedPattern.beginDraw();
  //feedPattern.background(255);
  //feedPattern.noFill();
  //feedPattern.stroke(0);
  //feedPattern.strokeWeight(10);
  //feedPattern.rectMode(CENTER);

  //feedPattern.translate(width / 2, height / 2);
  feedPattern.push();
  //feedPattern.rotate(radians(12));
  //feedPattern.ellipse(0, 0, width / 4, width / 4);
  //feedPattern.noStroke();
  //feedPattern.fill(0);
  
  //feedPattern.push();
  //feedPattern.translate(-40, -30);
  //feedPattern.ellipse(0, 0, 20, 20);
  //feedPattern.pop();
  
  //feedPattern.push();
  //feedPattern.translate(40, -30);
  //feedPattern.ellipse(0, 0, 20, 20);
  //feedPattern.pop();

  //feedPattern.push();
  //feedPattern.translate(-width / 12, 20);
  //feedPattern.stroke(0);
  //feedPattern.line(0, 0, width / 6, 0);
  //feedPattern.pop();
  feedPattern.image(victoria, 0, 0);
  feedPattern.filter(THRESHOLD);
  feedPattern.pop();
  
  feedPattern.endDraw();
  
  
  //victoria.loadPixels();
  //victoria.filter(THRESHOLD);
  //victoria.updatePixels();

  PImage foodsource = feedPattern;

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int c = foodsource.pixels[x + y * width];
      float bright = brightness (c);
      if (bright < 255) {
        float a = 1;
        float b = 1;
        grid[x][y] = new Cell(a, b);
        prev[x][y] = new Cell(a, b);
      }
    }
  }
}

float dA = 1.0;
float dB = 0.5;
float feed = 0.055;
float k = 0.062;

class Cell {
  float a;
  float b;

  Cell(float a_, float b_) {
    a = a_;
    b = b_;
  }
}


void update() {
  for (int i = 1; i < width-1; i++) {
    for (int j = 1; j < height-1; j ++) {

      Cell spot = prev[i][j];
      Cell newspot = grid[i][j];

      float a = spot.a;
      float b = spot.b;

      float laplaceA = 0;
      laplaceA += a*-1;
      laplaceA += prev[i+1][j].a*0.2;
      laplaceA += prev[i-1][j].a*0.2;
      laplaceA += prev[i][j+1].a*0.2;
      laplaceA += prev[i][j-1].a*0.2;
      laplaceA += prev[i-1][j-1].a*0.05;
      laplaceA += prev[i+1][j-1].a*0.05;
      laplaceA += prev[i-1][j+1].a*0.05;
      laplaceA += prev[i+1][j+1].a*0.05;

      float laplaceB = 0;
      laplaceB += b*-1;
      laplaceB += prev[i+1][j].b*0.2;
      laplaceB += prev[i-1][j].b*0.2;
      laplaceB += prev[i][j+1].b*0.2;
      laplaceB += prev[i][j-1].b*0.2;
      laplaceB += prev[i-1][j-1].b*0.05;
      laplaceB += prev[i+1][j-1].b*0.05;
      laplaceB += prev[i-1][j+1].b*0.05;
      laplaceB += prev[i+1][j+1].b*0.05;

      newspot.a = a + (dA*laplaceA - a*b*b + feed*(1-a))*1;
      newspot.b = b + (dB*laplaceB + a*b*b - (k+feed)*b)*1;

      newspot.a = constrain(newspot.a, 0, 1);
      newspot.b = constrain(newspot.b, 0, 1);
    }
  }
}

void swap() {
  Cell[][] temp = prev;
  prev = grid;
  grid = temp;
}

void draw() {
  println(frameRate);

  for (int i = 0; i < 1; i++) {
    update();
    swap();
  }

  loadPixels();
  for (int i = 1; i < width-1; i++) {
    for (int j = 1; j < height-1; j ++) {
      Cell spot = grid[i][j];
      float a = spot.a;
      float b = spot.b;
      int pos = i + j * width;
      pixels[pos] = color((a-b)*255);
    }
  }
  updatePixels();
  if (frameCount < 3000) {
    saveFrame("./output/frame-####.tif");
  } else {
    exit();
  }
  //image(feedPattern, 0, 0);
}
