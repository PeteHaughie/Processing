//String chars = " ░▒▓▔▕▖▗▘▙▚▛▜▝▞▟";
String chars = " -\\|/%#▚▜ ";
PFont f;

void setup() {
  background(0);
  size(450, 450);
  rectMode(CENTER);
  f = createFont("C64_Pro_Mono_v1.0-STYLE.ttf", 12);
  textFont(f);
}

void draw() {
  background(0);
  noStroke();
  fill(255);
  int characterPos = (int) map(sin(radians(frameCount)), -1, 1, 0, chars.length() - 1);
  translate(width / 4, 0);
  translate(0, height / 2 - 40);
  push();
  for(int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      text(chars.charAt(characterPos), i * 10, j * 10);
    }
  }
  pop();
  fill(map(sin(radians(frameCount)), -1, 1, 0, 255));
  rect(width / 2 - 50, 40, 100, 100);
  saveFrame("./output/frame-####.tif");
}
