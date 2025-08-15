// Loop duration in seconds
float loopTime = 20.0;
float rotateXSpeed = TWO_PI / loopTime;  // Full rotation in `loopTime` seconds
float rotateYSpeedFactor = 0.75;          // Modify this factor to control relative Y speed

void setup() {
  size(1920, 1080, P3D);
  frameRate(10);
}

void draw() {
  background(0);
  lights();
  directionalLight(255, 255, 255, -1, -1, -1);  // Light from above, right, and behind
  translate(width / 2, height / 2, 0);

  // Calculate the current time as a fraction of the loop duration
  float t = (millis() % (loopTime * 1000)) / (loopTime * 1000.0);

  // Angle progresses from 0 to TWO_PI for both rotations over the loop time
  float rotateXAngle = TWO_PI * t;
  float rotateYAngle = TWO_PI * t * rotateYSpeedFactor;

  // Apply the rotations
  rotateX(-rotateXAngle);
  rotateY(rotateYAngle);
  
  if (rotateXAngle == 0.0 && rotateYAngle == 0.00 && frameCount > 10) {
    println(rotateXAngle, rotateYAngle);
    println((millis() / 1000) * 60);
    exit();
  }


  fill(255, 0, 0);  // Red shape
  noStroke();
  lightSpecular(255, 255, 255);
  shininess(1.0);
  box(300);  // Draw cube with 300px dimensions
  //saveFrame("output/####.png");
}

void keyPressed() {
  if (key == char('q')) {
    exit();
  }
}
