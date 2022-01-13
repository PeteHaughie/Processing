void drawScene() {
  scene.beginDraw();

  scene.camera(
    eyeX,
    eyeY,
    eyeZ,
    centerX,
    centerY,
    centerZ,
    upX,
    upY,
    upZ
  );

  scene.perspective(PI / 3.0, (float) width / height, 1, DOMESIZE);
  
  // skybox
  scene.fill(#0000FF);
  scene.noStroke();

  scene.push();
  scene.translate(scene.width / 2, scene.height / 2);
  scene.rotateY(radians(frameCount * 0.01));
  scene.texture(sky);
  scene.shape(dome);
  scene.pop();

  // floor
  scene.noStroke();
  scene.push();
  scene.translate(scene.width/2, scene.height/2 + 1200, cameraZ);
  scene.rotateY(radians(90 + mx));
  scene.rotateX(radians(90));
  scene.fill(BG);
  scene.translate(0, 20);
  scene.textureMode(NORMAL);
  scene.beginShape();
  scene.texture(floor);
  scene.vertex(-MAGNITUDE, -MAGNITUDE, 0, 0);
  scene.vertex(MAGNITUDE, -MAGNITUDE, 1, 0);
  scene.vertex(MAGNITUDE, MAGNITUDE, 1, 1);
  scene.vertex(-MAGNITUDE, MAGNITUDE, 0, 1);
  scene.endShape();
  scene.pop();
}
