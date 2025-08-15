PShader gaussianBlur;
PImage img;
PGraphics scene;
float startTime;

void setup() {
  size(700, 800, P2D);
  noStroke();
  
  // Initialize start time
  startTime = millis() / 100.0;
  
  // Load an image to apply the blur effect to
  img = loadImage("victoria.jpeg"); // Ensure this path is correct
  
  // Create the graphics buffer
  scene = createGraphics(width, height, P2D);
  
  // Load the shader
  gaussianBlur = loadShader("Bloom.frag");
}

void draw() {
  float currentTime = millis() / 1000.0 - startTime;
  
  // Render the scene to the graphics buffer
  scene.beginDraw();
  scene.background(0);
  scene.image(img, 0, 0, width, height);
  scene.endDraw();

  // Update shader uniforms
  gaussianBlur.set("iTime", currentTime);
  gaussianBlur.set("resolution", float(width), float(height));
  gaussianBlur.set("u_texture", scene);  
  
  // Apply the Gaussian blur shader

  shader(gaussianBlur);
  
  // Display the result
  // image(scene, 0, 0, width, height);
  fill(255);
  rect(0, 0, width, height);
}
