void portal() {
  int w = 100;
  int h = 200;
  g = otherScene.get(width / 2 - (w / 2), height / 2 - (h / 2), w, h);
  push();
  rectMode(CENTER);
  translate(width / 2, height / 2, 0);
  stroke(10);
  image(g, 0, 0, w, h);
  pop();
}
