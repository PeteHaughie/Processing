float xxmin = -2.0,
      xxmax = 2.0,
      yymin = -2.0,
      yymax = 2.0,
      pres = 900;

float xinc = pres/(xxmax-xxmin),
      yinc = pres/(yymax-yymin),
      a = 2.24,
      b = 0.43,
      c = -0.65,
      d = -2.43,
      x = 0.0,
      y = 0.0,
      z = 0.0,
      e = 1;

void setup() {
  background(255);
  size(900, 900, P3D);
  stroke(0);
}

void draw() {
  for (int i = 0; i < 500; i++) {
    float xx = sin(a*y) - z*cos(b*x);
    float yy = z*sin(c*x) - cos(d*y);
    float zz = e*sin(x);
    x = xx;
    y = yy;
    z = zz;
    if (xx < xxmax && xx > xxmin && yy < yymax && yy > yymin) {
      float xxx = (xx - xxmin) * xinc;
      float yyy = (yy - yymin) * yinc;
      point(xxx, yyy);
    }
  }
  if (frameCount > 1000) {
    exit();
  } else {
    saveFrame("./output/frame-####.tif");
  }
}
