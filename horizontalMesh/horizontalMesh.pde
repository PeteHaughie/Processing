int gridsize = 0;

PImage victoria;
PShape mesh;

void setup() {
  size(640, 640, P3D);
  noStroke();
  victoria = loadImage("victoria.jpeg");
  mesh = horizontal_linemesh(10, victoria);
}

void draw() {
  background(0);
  shape(mesh);
}

PShape horizontal_linemesh(int gridsize, PImage img) {
  int new_gridsize = gridsize * 2;
  PShape mesh = createShape();
  mesh.beginShape(LINES);
  mesh.texture(img);  // Apply the texture
  float rescale = 1.0 / new_gridsize;
  
  for (int i = 0; i < new_gridsize; i++) {
    for (int j = 0; j < new_gridsize; j++) {
      float x0 = j * width / new_gridsize;
      float x1 = (j + 1) * width / new_gridsize;
      float y0 = i * height / new_gridsize;

      float tex_x0 = j * rescale;
      float tex_x1 = (j + 1) * rescale;
      float tex_y0 = i * rescale;

      mesh.vertex(x0, y0, tex_x0, tex_y0);
      mesh.vertex(x1, y0, tex_x1, tex_y0);
    }
  }
  
  mesh.endShape();
  return mesh;
}
