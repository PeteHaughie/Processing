/*
  this is just a proof of concept
  there are parts missing - there is no backend
  @TODO:
  Take an external string
  Resize typeface to fit screen regardless of length
  Take background image from *somewhere*
  Maybe degrade or otherwise fuck with image over time
*/

String str = "The moon hung low over the harbour the night you threw yourself in";
PImage img;
void setup(){
  size(1080, 720);
  noStroke();
  rectMode(CENTER);
  img = loadImage("https://fastly.picsum.photos/id/1013/1080/720.jpg?blur=2&hmac=rSWeioPustFudC_62sKVONY6vRmtqElzn5VeJRLevrk");
 }

int offset = 50;

void draw(){
  background(0);
  image(img, 0, 0, width, height);
  smooth(2);
  fill(255, 255, 255, 150);
  textSize(str.length() * 1.5);
  textLeading(str.length() * 1.5);
  text(str.toUpperCase(), width / 2, height / 2, width - offset, height - offset);
}

void keyPressed() {
  if (key == char('s')) {
    save("output.png");
  }
}
