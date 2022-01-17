float a = -0.966918;
float b = 2.879879;
float c = 0.765145;
float d = 0.744728;
float x = 0.1;
float y = 0.1;

void setup() {
  background(255);
  size(900, 900, P2D);
  stroke(0);
}

void draw() {
  translate(width / 2, height / 2);
  if (count < 10000000) {
    kingsDream();
  } else {
    exit();
  }
}

int count = 0; 

void kingsDream() {
  int step = 100;
  for (int j = 0; j < step; j++) {
    float xnew = sin(y*b) + c*sin(x*b);
    float ynew = sin(x*a) + d*sin(y*a);
    x = xnew;
    y = ynew;
    point(x * 200, y * 200);
  }
  count += step;
  saveFrame("./output/frame-####.tif");
}
