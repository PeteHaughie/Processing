void interactionKeyboard() {
  if (keyPressed) {
    if (key == 'w') {
      cameraZ += speed;
    } else if (key == 's') {
      cameraZ -= speed;
    } else if (key == 'p'){
     saveFrame("snapshot/snap-####.tif"); 
    }
  }
}
