PImage victoria,
       grid1,
       grid2,
       grid3,
       grid4;

float x,
      y;

void setup() {
  size(400, 400);
  victoria = loadImage("../assets/victoria.jpeg");
  ResizeImage(victoria);
  grid1 = victoria.get(0, 0, width / 2, height / 2);

  grid2 = victoria.get(width / 2, 0, width / 2, height / 2);
  
  grid3 = victoria.get(0, height / 2, width / 2, height / 2);
  grid4 = victoria.get(width / 2, height / 2, width / 2, height / 2);
}

void update() {
  x = map(sin(radians(frameCount)), -1, 1, 150, width - 150);
  y = map(cos(radians(frameCount)), -1, 1, 150, height - 150);
}

void draw() {
  background(255);
  update();
  
  image(grid1, 0, 0, x, y);
  image(grid2, x, 0, 400 - x, 150 + (y - 150));
  image(grid3, 0, y, x, 400 - y);
  image(grid4, x, y, 400 - x , 400 - y);
  
  //noStroke();
  //fill(255, 0, 0);
  //ellipse(x, y, 3, 3);
  //println(x, y);
  if (frameCount >= 320) {
    exit();
  }
  saveFrame("./output/frame-####.tif");
}
