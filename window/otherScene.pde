void drawOtherScene() {
  // other scene
  otherScene.beginDraw();

  otherScene.camera(
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

  otherScene.perspective(PI / 3.0, (float) width / height, 1, DOMESIZE);
  // skybox
  otherScene.fill(#0000FF);
  otherScene.noStroke();

  otherScene.push();
  otherScene.translate(otherScene.width / 2, otherScene.height / 2);
  otherScene.rotateY(radians(frameCount * 0.01));
  otherScene.texture(galaxy);
  otherScene.shape(otherDome);
  otherScene.pop();

  // floor
  otherScene.noStroke();
  otherScene.push();
  otherScene.translate(otherScene.width/2, otherScene.height/2 + 1200, cameraZ);
  otherScene.rotateY(radians(90 + mx));
  otherScene.rotateX(radians(90));
  otherScene.fill(BG);
  otherScene.translate(0, 20);
  otherScene.textureMode(NORMAL);
  otherScene.beginShape();
  otherScene.texture(floor);
  otherScene.vertex(-MAGNITUDE, -MAGNITUDE, 0, 0);
  otherScene.vertex(MAGNITUDE, -MAGNITUDE, 1, 0);
  otherScene.vertex(MAGNITUDE, MAGNITUDE, 1, 1);
  otherScene.vertex(-MAGNITUDE, MAGNITUDE, 0, 1);
  otherScene.endShape();
  otherScene.pop();
  
  otherScene.endDraw();
}
