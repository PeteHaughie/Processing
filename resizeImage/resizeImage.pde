/*
# Resize Image an image and preserve its aspect ratio without having to edit in external software
http://opensourcehacker.com/2011/12/01/calculate-aspect-ratio-conserving-resize-for-images-in-javascript/
*/

PImage image;

void setup() {
  size(400, 400);
  image = loadImage("victoria.jpeg");
  ResizeImage(image);
}

void draw() {
  image(image, 0, 0);
}
