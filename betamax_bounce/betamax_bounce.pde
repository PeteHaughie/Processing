PShape logo;

PVector pos;

float x,
  y,
  speed;

boolean up,
  left;

int r,
    g,
    b;

float r_int,
      g_int,
      b_int;

void setup() {
  background(0);
  size(320, 240);
  logo = loadShape("Logo_betamax_01.svg");
  logo.scale(.25);
  logo.disableStyle();
  r = 0;
  g = 0;
  b = 0;
  speed = 1;
  up = false;
  left = false;
  pos = new PVector(x, y);
  pos.x = random(logo.width / 2, width - logo.width / 2);
  pos.y = random(logo.height / 2, height - logo.height / 2);
}

void update() {

  if (pos.x + (logo.width / 4) > width) {
    left = true;
  }
  if (pos.x < 0) {
    left = false;
  }

  if (pos.y + (logo.height / 4) > height) {
    up = true;
  }
  if (pos.y < 0) {
    up = false;
  }

  if (up) {
    pos.y -= speed;
  } else {
    pos.y += speed;
  }

  if (left) {
    pos.x -= speed;
  } else {
    pos.x += speed;
  }

  r_int += 0.1;
  g_int += 0.2;
  b_int += 0.3;
  r = floor(map(sin(radians(r_int)), -1, 1, 0, 255));
  g = floor(map(sin(radians(g_int)), -1, 1, 0, 255));
  b = floor(map(sin(radians(b_int)), -1, 1, 0, 255));
}

void draw() {
  background(0);
  update();
  fill(r, g, b);
  shape(logo, pos.x, pos.y);
  if (frameCount < 3000) {
    saveFrame("./output/frame-####.tif");
  } else {
    exit();
  }
}
