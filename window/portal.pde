void portal() {
  int w = 200;
  int h = 200;
  g = otherScene.get(width / 2 - (w / 2), height / 2 - (h / 2), w, h);
  push();
  fill(0);
  rectMode(CENTER);
  translate(width / 2, height / 2, 0);
  stroke(0);
  strokeWeight(2);
  image(g, 0, 0, w, h);
  pop();

  push();
  rectMode(CENTER);
  translate((width / 2) - (w / 2), (height / 2) - (h / 2), 0);
  fill(0);
  portal.beginShape();
  portal.fill(0);
  portal.stroke(0);
  portal.strokeWeight(2);
  portal.setTexture(g);
  portal.vertex(0, 0, 0);
  portal.vertex(w, 0, 0);
  portal.vertex(w/2, h, 0);
  portal.endShape(CLOSE);
  //image(g, 0, 0, w, h);
  pop();
}
