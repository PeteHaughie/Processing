
void setup() {
  size(1750 / 3, 2474 / 3);
  noStroke();
  ellipseMode(CORNER);
  noLoop();
}

void draw() {
  background(255);
  fill(0);
  float col = 5; // our initial seed number
  float objH = width / col;
  float accHeight = 0;
  for (int y = 0; y <= 100; y++){
    float objW = objH;
    for (int x = 0; x < col; x++){
      ellipse(
       objW * x, // move along the x axis
       accHeight,
       objW,
       objH
      );
    }
    col += 2; // the number of new additions per row
    accHeight += objH;
    objH = width / col; // it's a circle so copy the width I guess
  }
}

void keyPressed() {
  if (key == char('s')) {
    save("output.png");
  }
}
