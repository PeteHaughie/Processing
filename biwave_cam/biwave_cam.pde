import processing.video.*;

float xoff = 0;
float  yoff = 0;
float[] xoffArr;
PGraphics screen;

Capture cam;

void setup() {
  background(0);
  size(600, 600);
  xoffArr = new float[width];
  for (int i = 0; i < height ; i++) {
    xoff += 0.01;
    xoffArr[i] = noise(xoff);
  }
  // load capture device
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    screen = createGraphics(width, height);
    cam = new Capture(this, cameras[0]);
    cam.start();
  }      
}

void draw() {
  smooth(1);
  xoff += 0.01;
  if (cam.available() == true) {
    cam.read();
  }
  screen.beginDraw();
  screen.image(cam, 0, 0);
  screen.endDraw();
  // read image from top to bottom
  for (int i = 0; i < height; i++) {
    // grab a "slice" of the image and paint it to the screen with npoise and offset
    image(screen.get(0, i, width, 1), 0 + noise((i * 0.001) + xoff) * 50, i - noise((i * 0.001) + xoff) * 50);
  }
}
