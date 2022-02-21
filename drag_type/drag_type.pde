String text = "DRAG ME";

PFont f;

PGraphics screen;
PImage buffer,
       snap;

PVector mouseDrop,
        mouseEnd;

boolean mouseMoving = false;

void setup() {
  size(900, 900);
  background(0);
  f = createFont("Arial Black.ttf", 180);
  textAlign(CENTER);
  drawScreen();
  buffer = screen.copy();
  mouseDrop = new PVector();
  mouseEnd = new PVector();
}

void drawScreen() {
  screen = createGraphics(width, height);
  screen.beginDraw();
  //screen.background(0);
  screen.noStroke();
  screen.fill(255);
  screen.translate(width * 0.2, height * 0.5);
  screen.textSize(180);
  screen.text(text, 0, 0);
  screen.endDraw();
}

void draw() {
  image(buffer, 0, 0);
  if (snap != null) {
    image(snap, mouseX - snap.width, mouseY - snap.height);
  }
  //if (mouseMoving == true) {
  //  stroke(255, 0, 0);
  //  strokeWeight(2);
  //  noFill();
  //  rect(mouseDrop.x, mouseDrop.y, mouseEnd.x - mouseDrop.x, mouseEnd.y - mouseDrop.y);
  //}
}

void resetMouse() {
  mouseDrop.x = 0;
  mouseDrop.y = 0;
  mouseEnd.x = 0;
  mouseEnd.y = 0;
}

void keyPressed() {
  // press space to reset
  if (keyCode == 32) {
    clear();
    resetMouse();
    snap = null;
  }
  if (keyCode == 82) {
    image(screen, 0, 0);
    resetMouse();
    snap = null;
  }
  if (keyCode == 80) {
    saveFrame("./output/" + nf(year(), 4) + nf(month(), 2) + nf(day(), 3) + "-" + nf(hour()) + minute() + nf(second()) + ".png");
  }
}

void mousePressed() {
  mouseDrop.x = mouseX;
  mouseDrop.y = mouseY;
  mouseEnd.x = mouseX;
  mouseEnd.y = mouseY;
}

void mouseReleased() {
  mouseEnd.x = mouseX;
  mouseEnd.y = mouseY;
  mouseMoving = false;
  snap = buffer.get((int)mouseDrop.x, (int)mouseDrop.y, abs(int(mouseDrop.x - mouseEnd.x)), abs(int(mouseDrop.y - mouseEnd.y)));
}

void mouseDragged() {
  mouseMoving = true;
  mouseEnd.x = mouseX;
  mouseEnd.y = mouseY;
}
