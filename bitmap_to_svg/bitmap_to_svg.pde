import processing.svg.*;

color FG = #111111; //Graphic color ■
color BG = #f1f1f1; //Background color ■
PImage img; 

boolean saveSVG = false;

void setup() {
  size(1000, 1000); //Preview resolution ■
  background(BG);
  img = loadImage("victoria.jpeg"); //Image link ■
}

void draw() {
  
  if (saveSVG){
    beginRecord(SVG, "cyberus-####.svg");
  }
  
  background(BG);
  fill(FG);
  noStroke();
  
  float ratio = float(height)/float(width);
  float tilesX = map(mouseX, 0, width, 10, 300);
  float tilesY = ratio * tilesX;
  float tileSize = width / tilesX;
   
  for (int y = 0; y < img.height; y += tileSize) {
    for (int x = 0; x < img.width; x += tileSize) {
      
      color c = img.get(x, y);
      float b = map(brightness(c), 0, 255, 1, 0);
                  
      pushMatrix();
      translate(x, y);
      rect(0, 0, b * tileSize, b * tileSize);
      popMatrix();
  
    } //y
  } //x
  if (saveSVG){
    endRecord();
    saveSVG = false;
  }
}

void keyPressed() {
  if (key == 's'){
    saveSVG = true;
    println("Saved");
  }
}
