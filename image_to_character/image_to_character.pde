PImage victoria,
       temp;

String chars = " -\\|/%#▚▜ ";

PFont f;

int amt = 6,
    cellW,
    cellH,
    sumbrightness;

void setup() {
  background(255);
  size(600, 600);
  noStroke();
  stroke(0);

  cellW = width / amt;
  cellH = height / amt;
  
  victoria = loadImage("victoria.jpeg");
  
  ResizeImage(victoria);
  
  f = createFont("C64_Pro_Mono_v1.0-STYLE.ttf", cellW);
  textFont(f);
  saveFrame("./character.png");
  //noLoop();
}

int sumbrightness(PImage image) {
  image.loadPixels();
  int sumbrightness = 0;
  for (int i = 0; i < image.width; i ++) {
    for (int j = 0; j < image.height; j++) {
      float b = brightness (image.pixels[i * j]);
      sumbrightness += b;
    }
  }
  return sumbrightness / (image.width * image.height);
}

void grid() {
  for (int i = 0; i < width / amt; i++) {
    for (int j = 0; j < height / amt; j++) {
      temp = victoria.get(i * cellW, j * cellH, cellW, cellH);
      int b = sumbrightness(temp);
      fill(0);
      push();
      translate(i * cellW, j * cellH);
      text(chars.charAt((int) map(b, 255, 0, 0, chars.length() - 1)), 0, 0);
      pop();
    }
  }
}

void update() {
  amt = (int) map(mouseX, 0, width, 6, 24);
  cellW = width / amt;
  cellH = height / amt;
  textSize(cellW);
}

void draw() {
  background(255);
  update();
  grid();
  saveFrame("./output/frame-####.tif");
}
