class Branch {
  float[] xPositions = new float[255];
  float[] yPositions = new float[255];
  float[] zPositions = new float[255];
  float[] red_values = new float[255];
  float[] green_values = new float[255];

  void branch() {
  }
  
  void update() {
    for (int i = 0; i < 255; i++) {
      xPositions[i] = random(-1, 1);
      yPositions[i] = random(-1, 1);
      zPositions[i] = random(-1, 1);
      red_values[i] = i;
      green_values[i] = map(i, 0, 255, 255, 0);
    }
  }

  void draw() {
    noStroke();
    pushMatrix();
    for (int i = 0; i < 255; i++) {
      fill(red_values[i], green_values[i], 0);
      float x = xPositions[i];
      float y = yPositions[i];
      float z = zPositions[i];
      translate(x, y, z);
      sphere(1);
    }
    popMatrix();
  }
}
