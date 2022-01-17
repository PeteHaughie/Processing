float h = 0.001;
int npts = 4000;
float x, y, z = 0.6;
float frac = 8/3;

void setup() {
  size(900, 900, P3D);
  background(255);
  stroke(0);
}

void draw() {
  translate(width / 2, height / 2);

  float xold = 0,
        yold = 0,
        zold = 0;

  float xnew = 0,
        ynew = 0,
        znew = 0;

  beginShape();
  for (int i = 0; i < npts; i++) {

    xold = xnew;
    yold = ynew;
    zold = znew;

    xnew = x + h*10*(y-z);
    ynew = y + h*((-x*z) + 28*x-y); 
    znew = z + h*(x*y - frac*z);

    x = xnew; y = ynew; z = znew;

    line(xold, yold, xnew, ynew);
  }
  endShape();
}
