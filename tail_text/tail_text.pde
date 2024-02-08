PFont font;
PImage prevFrame;

void setup() {
  size(800, 800, P3D); // getting higher fs using P3D + added blur effect
  frameRate(60);
  font = createFont("Times New Roman", 144);
  textFont(font);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  noStroke();
}

void draw() {
  // Tweak ahoy! (play with these values by running the sketch in Tweak Mode)
  PVector shiftAmt = new PVector(3, -20); // shift on x and y axis respectively
  float scaleAmt = 1.006; // down > 1.0 < up
  float tiltAmt = 0.029; // angel in radians
  // Enter at own risk
  background(#E9548D);
  pushMatrix();
  translate(width/2, height/2);
  translate(shiftAmt.x, shiftAmt.y);
  scale(scaleAmt);
  rotate(tiltAmt);
  if (prevFrame != null) image(prevFrame, 0, 0);
  popMatrix();
  fill(0x11E9548D); // 0x = alternative to # that allows for setting the alpha (hex 11 in this case)
  rect(0, 0, width, height);
  fill(#142DBD);
  text("move", mouseX, mouseY);
  prevFrame = g.get();
}
