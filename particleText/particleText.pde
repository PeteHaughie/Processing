Particle[] particle;

PImage img;

int count = 0;
int iterator = 0;
float size = 25;

void setup() {
  background(255);
  size(450, 450, P2D);
  pixelDensity(2);
  noStroke();
  colorMode(RGB);
  img = loadImage("puppies.jpg");
  int dimensions = img.width * img.height;
  
  for (int i = 0; i < dimensions; i++) {
    float r = red (img.pixels[i]);
    float g = green (img.pixels[i]);
    float b = blue (img.pixels[i]);
    if (r < 240 && g < 240 && b < 240) {
      count++;
    }
  }
  particle = new Particle[count];
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int loc = x + y * img.width;
      float r = red (img.pixels[loc]);
      float g = green (img.pixels[loc]);
      float b = blue (img.pixels[loc]);
      if (r < 240 && g < 240 && b < 240) {
        particle[iterator] = new Particle();
        particle[iterator].origin.x = x + (width / 2) - (img.width / 2);
        particle[iterator].origin.y = y + (height / 2) - (img.height / 2);
        iterator++;
      }
    }
  }
}

float wave = 0;

void draw() {
  background(255);
  fill(255,0,0);
  wave = map(cos(frameCount * 0.031), -1, 1, size, width - size);
  noStroke();
  ellipse(wave, height / 2, size * 2, size * 2);
  for (int i = 0; i < particle.length; i++) {
    particle[i].all(wave, size, height / 2);
  }
}
