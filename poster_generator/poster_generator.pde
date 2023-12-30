PImage[] images;

PGraphics source;
PGraphics target;
PGraphics result;
PGraphics artboard;

PImage buffer;
PImage currImage;

int POSTER_W = 1792 / 3;
int POSTER_H = 720;

float TILES_X = POSTER_W / 5;
float TILES_Y = POSTER_H / 5;

int sx, sy, sw, sh, dx, dy, dw, dh;

float scaler = 1;

float offsetX = 0;
float offsetY = 0;

int count = 0000;

boolean record = false;


void setup() {
  size(1792, 720);
  source = createGraphics(POSTER_W, POSTER_H);
  target = createGraphics(POSTER_W, POSTER_H);
  result = createGraphics(POSTER_W, POSTER_H); 
  artboard = createGraphics(POSTER_W, POSTER_H); 

  images = new PImage[4];
  images[0] = loadImage("1.png");
  images[1] = loadImage("2.png");
  images[2] = loadImage("3.png");
  images[3] = loadImage("4.png");

  currImage = images[0];
}

void draw() {
  background(#f1f1f1);
  drawSource();
  drawTarget();
  drawResult();
  drawArtboard();

  image(source, 0, 0);
  image(target, POSTER_W, 0);
  image(result, POSTER_W + POSTER_W, 0);
  noFill();
  stroke(#00ff00);
  strokeWeight(3);

  rect(mouseX, mouseY, sw, sh);
  rect(mouseX + POSTER_W, mouseY, sw, sh);
  
  if (record)
      render();
}

void drawSource(){
  source.beginDraw();
  source.background(0);
  source.imageMode(CENTER);
  source.push();
  source.translate(source.width / 3 + offsetX, source.height / 2 + offsetY);
  source.scale(scaler);
  source.image(currImage, 0, 0);
  source.pop();
  source.endDraw();
}

void drawTarget(){
  target.beginDraw();

  buffer = source.get();

  if (frameCount == 1) {
    target.background(#ffffff);
  }

  sx = mouseX;
  sy = mouseY;
  sw = 100;
  sh = 100;

  dx = mouseX;
  dy = mouseY;
  dw = 100;
  dh = 100;

  if (mousePressed) {
    target.copy(buffer, sx, sy, sw, sh, dx, dy, dw, dh);
  }
  target.endDraw();
}

void drawResult(){

  float tileW = result.width / TILES_X;
  float tileH = result.height / TILES_Y;

  PImage buffer = target.get();

  result.beginDraw();
  result.background(#f1f1f1);

  result.noStroke();

  for (int x = 0; x < TILES_X; x++){
    for (int y = 0; y < TILES_Y; y++){ 

      int px = int(x * tileW);
      int py = int(y * tileH);
      color c = buffer.get(px, py);
      float b = brightness(c);

      if (b < 100) {
        result.fill(0);
      } else {
        result.fill(#f1f1f1);
      }

      result.push();
      result.translate(x * tileW, y * tileH);
      result.rect(0, 0, tileW, tileH);
      result.pop();

    } 
  }
  result.endDraw();
}

void drawArtboard(){
  artboard.beginDraw();
  artboard.background(0);
  artboard.imageMode(CENTER);
  PImage buffer = result.get();
  artboard.image(buffer, artboard.width / 3, artboard.height / 2);
  artboard.endDraw();
}

void mousePressed() {
  record = true;
}

void mouseReleased() {
  record = false;
}

void render(){
  result.save("output/" + count + ".png");
  count += 1;
}

void keyPressed() {
  if (key == 's') {
    render();
  }
}
