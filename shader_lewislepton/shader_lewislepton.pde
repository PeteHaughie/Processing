PShader myShader;
PGraphics buffer;

Col c = new Col(0.0, 0.0, 0.0);

float mapf(float x, float in_min, float in_max, float out_min, float out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

void setup() {
  size(400, 400, P2D);
  myShader = loadShader("shader.frag");
  myShader.set("u_resolution", (float) width, (float) height);
  buffer = createGraphics(width, height, P2D);
}

class Col {
  float x, y, z;
  PVector colVec3 = new PVector(x, y, z);
  
  Col (float _x, float _y, float _z) {
    x = _x;
    y = _y;
    z = _z;
  }
  
  void update(float _t) {
    colVec3.x = mapf(sin(radians(_t * 0.01)), -1, 1, 0, 1);
    colVec3.y = mapf(sin(radians(_t * 0.02)), -1, 1, 0, 1);
    colVec3.z = mapf(sin(radians(_t * 0.03)), -1, 1, 0, 1);
  }
}

void updateBuffer() {
  buffer.beginDraw();
  shader(myShader);
  buffer.endDraw();
}

void draw() {
  myShader.set("u_time", (float) millis() / 1000);
  c.update(millis());
  myShader.set("u_color", c.colVec3);
  updateBuffer();
  image(buffer, 0, 0);
}
