PVector a,
        b,
        c,
        p;

float distance = 0.5,
      x, y;

void setup() {
  background(0);
  size(800, 800);

  a = new PVector(x, y);
  b = new PVector(x, y);
  c = new PVector(x, y);
  p = new PVector(x, y);

  a.x = width / 2;
  a.y = 10;

  b.x = width - 20;
  b.y = height - 10;

  c.x = 10;
  c.y = height - 10;

  p.x = random(width);
  p.y = random(height);
  
  strokeWeight(3);
  
  stroke(255, 0, 0);
  point(a.x, a.y);
  
  stroke(0, 255, 0);
  point(b.x, b.y);
  
  stroke(0, 0, 255);
  point(c.x, c.y);
  
  strokeWeight(10);
  stroke(255, 0, 255);
  point(p.x, p.y);
}

void findPoints() {
  strokeWeight(1);

  for (int i = 0; i < 1000; i++) {
    int r = floor(random(3));
    
    switch(r) {
      case 1 :
        stroke(0, 255, 0, 10);
        p.x = lerp(p.x, b.x, distance);
        p.y = lerp(p.y, b.y, distance);
      break;
      case 2 :
        stroke(0, 0, 255, 10);
        p.x = lerp(p.x, c.x, distance);
        p.y = lerp(p.y, c.y, distance);
      break;
      default :
        stroke(255, 0, 0, 10);
        p.x = lerp(p.x, a.x, distance);
        p.y = lerp(p.y, a.y, distance);
      break;
    }
    point(p.x, p.y);
  }
}

void draw() {
  findPoints();
}

void keyPressed() {
  if (key == ' ') {
    clear();
    strokeWeight(10);
    stroke(255, 0, 255);
    p.x = random(width);
    p.y = random(height);
    point(p.x, p.y);
  }
}
