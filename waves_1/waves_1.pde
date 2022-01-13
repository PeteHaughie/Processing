/**
 * This is a reconstruction of Tim Rodenbroeker's
 * "Exploring Wave-Figures in Processing" YouTube course
 * https://www.youtube.com/watch?v=Th7m7QEeUbI
*/

void setup() {
  size(450, 450);
  pixelDensity(2);
  background(0);
}

void draw() {
  translate(width / 2, height / 2);
  scale(0.5);
  float mag = 200;
  float size = 5;
  float amount = 100;
  noStroke();
  for (int i = 0; i < amount; i++) {
    float w = map(sin(radians(frameCount)), -1, 1, -100, 100);
    float wave1 = map(tan(radians(frameCount * 0.8 + i + w)), -1, 1, -100, 100);
    float wave2 = map(cos(radians(frameCount + i)), -1, 1, -mag, mag);
    float c = map(sin(radians(frameCount * 2 + i)), -1, 1,  0, 255);
    fill(c);
    rect(wave1, wave2, size, size);
  }
}
