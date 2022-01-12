String[] lines;

void setup() {
  size(900, 900);
  background(0);
  color(255);
  noStroke();
  noLoop();
  lines = loadStrings("./recursive_code_sketch.pde");
}

void draw() {
  for (int i = 0; i < lines.length; i++) {
    println(lines[i]);
    text(lines[i], 20, 40 + (20 * i));
  }
}
