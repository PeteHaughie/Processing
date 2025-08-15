int numPlanes = 300;
int numParticles = 5000;
int W = 300;
int H = 300;
PGraphics[] planes;
Particle[][] particles;

void setup() {
  size(600, 600, P3D);
  planes = new PGraphics[numPlanes];
  particles = new Particle[numPlanes][numParticles];
  for (int i = 0; i < numPlanes; i++) {
    planes[i] = createGraphics(W, H);
    for (int j = 0; j < numParticles; j++) {
      particles[i][j] = new Particle();
    }
    drawParticlesToLayer(i);
  }
  noLoop();
}

void drawParticlesToLayer(int i) {
  planes[i].beginDraw();
  planes[i].background(0, 0);
  planes[i].stroke(255);
  
  for (Particle p : particles[i]) {
    float px = map(p.x, -1, 1, 0, W);
    float py = map(p.y, -1, 1, 0, H);
    planes[i].point(px, py);
  }
  planes[i].endDraw();
}

void draw() {
  background(0);
  ortho();
  translate(width / 2, height / 2, 0);
  rotateX(PI / 6);
  rotateY(PI/ 6);
  
  for (int i = 0; i < numPlanes; i++) {
    pushMatrix();
    translate(0, 0, -i);
    image(planes[i], -50, -50, W, H);
    popMatrix();
  }
  saveFrame("frame.png");
}
