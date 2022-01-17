float s1 = 0.0,
      r = 0.0,
      x = 0.0,
      y = 0.0,
      z = 0.0,
      numstars = 0.0,
      a = 0.0,
      b = 0.0,
      c = 0.0,
      d = 0.0,
      rnd = 0.0,
      r0 = 0.0,
      r1 = 0.0,
      r2 = 0.0,
      r3 = 0.0,
      pi = 0.0,
      c0 = 0.0,
      c1 = 0.0;

int i = 0,
    k = 0;

void setup() {
  background(255);
  size(900, 900, P3D);
  translate(width / 2, height / 2);
  stroke(0);
  r0 = 20.0;
  r2 = r0*r0;
  r3 = r2*r0;
  pi = PI;
  c0 = pi*pi*r3/4.0;
  // 923784651
  r1 = r0/sqrt(2.0);
  numstars = 10000;
  for (int i = 0; i < numstars; i++) {
    rnd = random(0,1)/32767;
    c = c0*rnd;
    r = r1;
    for (int k = 1; k <= 5; k++) {
      a = r/r0;
      c1 = atan(a)*0.5*r3;
      a = 1+a*a;
      c1 = c1+r*0.5*r2/a;
      c1 = pi*(c1-r*r2/(a*a));
      d = 4.0*pi*r*r/(a*a*a);
      r = r+(c-c1)/d;
    }
    do { 
      x = (random(0, 1)/32767.) - 0.5;
      y = (random(0, 1)/32767.) - 0.5;
      z = (random(0, 1)/32767.) - 0.5;
      s1 = sqrt(x * x + y * y + z * z);
      r = r/s1;
      x = x*r;
      y = y*r;
      z = z*r;
      point(x, y, z);
    } while (s1 > 0.5);
  }
}

void draw() {
}
