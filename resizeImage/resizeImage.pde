/*
# Resize Image an image and preserve its aspect ratio without having to edit in external software
http://opensourcehacker.com/2011/12/01/calculate-aspect-ratio-conserving-resize-for-images-in-javascript/
*/

PImage victoria,
       image1,
       image2;

void setup() {
  size(400, 400);
  victoria = loadImage("victoria.jpeg");
  image1 = victoria.copy();
  ResizeImage(image1);
  image2 = victoria.copy();
  ResizeImage(image2, 250);
  noLoop();
}

void draw() {
  image(victoria, 0, 0);
  saveFrame("./original.png");
  image(image1, 0, 0);
  saveFrame("./unscaled.png");
  image(image2, 0, 0);
  saveFrame("./scaled.png");
}
