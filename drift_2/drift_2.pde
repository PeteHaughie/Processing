
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
      yoff = 0;

void line() {

  push();
  translate(cellW / 2, cellH / 2);


  for (int i = 0; i < amt; i++) {
    for (int j = 0; j < amt; j++) {
            
      float wxoff = map(sin(radians(xoff * 250)), 0.0, 0.25, -0.2, 0.2);
      float wyoff = map(sin(radians(yoff * 250)), 0.0, 0.50, -0.2, 0.2);
      float x = map(noise(wxoff + (i * 0.15) * 0.1, wyoff + (j * 0.1) * 0.15), 0, 1, -150, 150);
      float y = map(noise(wxoff + (i * 0.25) * 0.2, wyoff + (j * 0.2) * 0.25), 0, 1, -150, 150);
      
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
  xoff += 0.003;
  yoff += 0.005;
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
