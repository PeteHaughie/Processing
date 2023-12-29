PShader myShader;
PGraphics buffer;

void setup() {
    size(640, 480, P2D);
    buffer = createGraphics(width, height, P2D);

    // Load the shader
    myShader = loadShader("shader.glsl");
    myShader.set("uResolution", (float) width, (float) height);
}

void draw() {
    // Apply the shader to the buffer
    buffer.beginDraw();
    buffer.noStroke();
    buffer.image(buffer, 0, 0); // Draw the buffer onto itself
    buffer.ellipse(mouseX, mouseY, 10, 10);
    buffer.fill(255);
    buffer.shader(myShader);
    buffer.endDraw();

    // Draw the buffer to the screen
    image(buffer, 0, 0);
    // Update the uniform texture
    myShader.set("buffer", buffer);
    myShader.set("uGlobalTime", millis() / 1000);
}
