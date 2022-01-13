void update() {
  
  mx = map(mouseX, 0, width, width, 0);
  my = map(mouseY, 0, height, height, 0);

  eyeX = width/2.0;
  eyeY = height/2.0 + my;
  eyeZ =(height/2.0) / tan(PI * 30.0 / 180.0);

  centerX = width/2.0;
  centerY = height/2.0;
  centerZ = 0;

  upX = 0;
  upY = 1;
  upZ = 0;
}
