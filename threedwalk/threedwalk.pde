ArrayList<Branch> branches = new ArrayList<Branch>();

int num_branches = 10;
int depth;

void setup() {
  background(0);
  size(450, 450, P3D);
  pixelDensity(2);
  frameRate(60);
  depth = width;
  for (int i = 0; i < num_branches; i++) {
    branches.add(new Branch());
  }
  for (int i = 0; i < num_branches; i++) {
    Branch branch = branches.get(i);
    for (int j = 0; j < 255; j++) {
      branch.update();
    }
  }
}

void draw() {
  background(0);
  translate(width / 2, height / 2, depth / 2);
  rotateX(radians(rotX));
  rotateY(radians(rotY));
  if (radians(rotX) > 25) {
    exit();
  }
  for (int i = 0; i < num_branches; i++) {
    Branch branch = branches.get(i);
    branch.draw();
  }
  update();
  saveFrame("output/screen-#####.tif");
}

float rotX = 0;
float rotY = 0;

void update() {
  rotX += 1.5;
  rotY += 1;
}
