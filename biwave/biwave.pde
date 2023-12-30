float xoff = 0;
float  yoff = 0;
float[] xoffArr;
PGraphics screen1;
PGraphics screen2;

PImage victoria;

void setup() {
  background(0);
  size(600, 600);
  xoffArr = new float[width];
  for (int i = 0; i < height ; i++) {
    xoff += 0.01;
    xoffArr[i] = noise(xoff);
  }
  victoria = loadImage("victoria.jpeg");
  // load text
  screen1 = createGraphics(width, height);
  screen1.beginDraw();
  screen1.textAlign(CENTER);
  screen1.textSize(300);
  screen1.text("HEX", width / 2, height / 2);
  screen1.endDraw();
  // load image
  screen2 = createGraphics(width * 2, height * 2);
  screen2.beginDraw();
  screen2.image(victoria, 0, 0);
  screen2.endDraw();

}
void draw() {
  smooth(1);
  xoff += 0.01;
  for (int i = 0; i < width * 2; i++) {
    image(screen2.get(0, i, width * 2, 1), (noise((i * 0.001) + xoff) * 125) - (width / 2), (i - (height / 4)) + (noise((i * 0.005) + xoff) * 100));
  }
  filter(INVERT);
  for (int i = 0; i < height; i++) {
    image(screen1.get(i, 0, 1, height), i, (noise((i * 0.001) + xoff) * 70));
  }
  filter(INVERT);
  for (int i = 0; i < height; i++) {
    image(screen1.get(i, 0, 1, height), i, (noise((i * 0.001) + xoff) * 100));
  }
}
