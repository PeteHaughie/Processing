PShader waveShader;
int cols, rows;
int scl = 20;  // Size of each quad in the grid
int w, h;

void setup() {
  size(800, 800, P3D);
  cols = width / scl;
  rows = height / scl;
  w = cols * scl;
  h = rows * scl;
  
  // Load the vertex and fragment shaders
  waveShader = loadShader("wave_fragment.glsl", "wave_vertex.glsl");
  
  // Set initial uniform values
  waveShader.set("u_time", 0.0);
  waveShader.set("u_amplitude", 50.0);
  waveShader.set("u_frequency", 0.1);
}

void draw() {
  background(255, 0, 0);
  
  // Update the time uniform for animation
  waveShader.set("u_time", millis() / 1000.0);
  
  // Apply the shader
  shader(waveShader);
  
  // Transform the grid for better visualization
  translate(width / 2, height / 2, -400);
//   rotateX(PI / 6);
//   rotateZ(PI / 4);
    rotateY(PI/3);  
  // Draw a plane of quads
  beginShape(QUADS);
  for (int y = 0; y < rows - 1; y++) {
    for (int x = 0; x < cols - 1; x++) {
      float x1 = x * scl - w / 2;
      float y1 = y * scl - h / 2;
      float x2 = (x + 1) * scl - w / 2;
      float y2 = y1;
      float x3 = x2;
      float y3 = (y + 1) * scl - h / 2;
      float x4 = x1;
      float y4 = y3;
      
      vertex(x1, y1, 0, x / (float)cols, y / (float)rows);
      vertex(x2, y2, 0, (x + 1) / (float)cols, y / (float)rows);
      vertex(x3, y3, 0, (x + 1) / (float)cols, (y + 1) / (float)rows);
      vertex(x4, y4, 0, x / (float)cols, (y + 1) / (float)rows);
    }
  }
  endShape();
  
  // Reset to default shader
  resetShader();
}
