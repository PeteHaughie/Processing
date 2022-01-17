// I couldn't get the example pseudo code from the book to work so this one is adapted from the C featured here:
// https://www.youtube.com/watch?v=ItCQ-MNcx6M&ab_channel=JwalinBhatt

/*
  for the sake of completion the original code is here:

float c1 = 0.4,
      c2 = 0.9,
      c3 = 6.0,
      rho = 1.0,
      x = 0.1
      y = 0.1,
      scale = 0,
      xoff = 0,
      yoff = 0;

for (int i = 0; i <= 3000; i++) {
  float temp = c1 - c3 / (1.0 + x * x + y * y);
  float sin_temp = sin(temp);
  float cos_temp = cos(temp);
  float xt = rho + c2 * (x*cos_temp-y*sin_temp);
  y = c2 * (x*sin_temp + y*cos_temp);
  x = xt;
  float j = x * scale + xoff;
  float k = y * scale + yoff;
}

scale, xoff, and yoff are never initialised so their values are unknown 

*/

float u = 0.9,
      x = 0.0,
      y = 0.0,
      tmp = 0.0,
      t = 0.0;

void setup() {
  background(255);
  size(900, 900, P2D);
  stroke(0);
}

int count = 0;
int step = 1000;

float c1 = 0.4,
      c3 = 6.0;

void draw() {
  translate(0, 100);
  if (count < 300000) {
    for (int i = 0; i < step; i++) {
      t = c1-(c3/(1+(x*x)+(y*y)));
      tmp = 1 + u*((x*cos(t))-(y*sin(t)));
      y = u*((x*sin(t))+(y*cos(t)));
      x = tmp;
      point((x*200)+300, (y*-200)+220, 0);
    }
    saveFrame("./output/frame-####.tif");
    count += step;
  } else {
    exit();
  }
}
