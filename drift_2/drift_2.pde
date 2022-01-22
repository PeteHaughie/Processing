
void setup() {
  size(900, 900, P2D);
  strokeCap(ROUND);
  cellW = (width - 200) / amt;
  cellH = (height - 200) / amt;
}

float amt = 40;
float cellW;
float cellH;

float xoff = 0,
      yoff = 0,
      phase = 0.05;

void line() {

  push();
  translate(cellW / 2, cellH / 2);


  for (int i = 0; i < amt; i++) {
    for (int j = 0; j < amt; j++) {
            
      float x = map(noise((i * 0.01) + phase, j * 0.01), 0, 1, -100, 100);
      float y = map(noise((i * 0.015) + phase, j * 0.015), 0, 1, -100, 100);
      
      push();
      // position it
      translate(i * cellW, j * cellH);
      
      // string of ellipses
      int num = 30;
      int dim = 10;
      
      float girth = map(dist(0, 0, x, y), 0, 150, 1, dim);
      for (int k = num; k >= 0; k--) {
        fill(map(k, 0, num, 255, 0), 75);
        noStroke();
        ellipse(x - ((x / num) * k), y - ((y / num) * k), girth, girth);
      }
      pop();

    }
  }
  phase += 0.05;
  xoff += phase;
  yoff += phase;
  pop();
}

void draw() {
  background(255);
  fill(0);
  translate(100, 100);
  rect(0, 0, width - 200, height - 200, 3);
  //grid();
  line();
  if (frameCount > 2000) {
    exit();
  }
  saveFrame("./output/frame-####.tif");
}

void grid() {
  push();
  noFill();
  stroke(255, 0, 0);
  strokeWeight(1);
  for (int i = 0; i < amt; i++) {
    for (int j = 0; j < amt; j++) {
      rect(i * cellW, j * cellH, cellW, cellH);
    }
  }
  pop();
}
