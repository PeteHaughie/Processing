int framesLength = 40;
ArrayList<PImage> frames = new ArrayList<PImage>();
int fontSize = 48;
String str = "move";
PGraphics buffer;
int mX, mY;

void setup() {
  size(600, 600);
  background(#E9548D);
  textSize(fontSize);
  textAlign(CENTER, CENTER);
  buffer = createGraphics(width, height);
  updateBuffer();
  for (int i = 0; i < framesLength; i++) {
    frames.add(buffer.get());
  }
  noStroke();
  noCursor();
}

void updateBuffer() {
  buffer.beginDraw();
  buffer.clear();
  buffer.textAlign(CENTER, CENTER);
  buffer.fill(#142DBD);
  buffer.text(str, mX, mY);
  buffer.textSize(fontSize);
  buffer.endDraw();
}

void draw() {
  updateBuffer();
  background(#E9548D);
  mX = mouseX;
  mY = mouseY;
  frames.remove(0);
  frames.add(buffer.get());
  push();
  translate(0, -((6 * fontSize) + (framesLength * 2)));
  push();
  for (int i = 0; i < framesLength - 1; i++) {
    //fill(#E9548D, 30);
    //rect(0, 0, width, height);
    translate(0, fontSize / (i + 2));
    image(frames.get(i), 0, (i * 6));
  }
  pop();
  pop();
  fill(#142DBD);
  text(str, mX, mY);
  //if (frameCount < 720) {
  //  saveFrame("output/frame-####.png");
  //} else {
  //  exit();
  //}
}
