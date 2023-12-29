import processing.video.*;

Capture cam;

PShader myShader;

void setup(){
    size(400, 400, P2D);
    myShader = loadShader("shader.frag");
    cam = new Capture(this);
    cam.start();
    PVector resolution = new PVector(width, height); // Create a PVector for resolution
    myShader.set("u_resolution", resolution); // Pass the PVector to the shader
}

void draw(){
    if (cam.available()) {
        cam.read();
        myShader.set("textureSampler", cam);
    }
    filter(myShader);
}
