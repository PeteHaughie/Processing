PShader ditherShader;
PImage testImg, ditherImg, paletteImg;

void setup() {
  size(256, 256, P2D);
  
  ditherShader = loadShader("ditherShader.glsl", "vertexShader.glsl");
  
  testImg = loadImage("test.png");
  ditherImg = loadImage("dither_matrix.png");
  paletteImg = loadImage("palette_eeve.png");
  
  ditherShader.set("u_dither_tex", ditherImg);
  ditherShader.set("u_color_tex", paletteImg);
  ditherShader.set("u_bit_depth", 16);   // Adjust this value accordingly
  ditherShader.set("u_contrast", 1.0); // Adjust this value accordingly
  ditherShader.set("u_offset", 0.0);   // Adjust this value accordingly
  ditherShader.set("u_dither_size", 16); // Adjust this value accordingly
  
  ditherShader.set("u_color_tex_size", float(paletteImg.width), float(paletteImg.height));
  ditherShader.set("u_dither_tex_size", float(ditherImg.width), float(ditherImg.height));
  
  shader(ditherShader);
}

void draw() {
    background(255);
    image(testImg, 0, 0, width, height);
    // image(ditherImg, 0, 0);
    // image(paletteImg, 0, 0);
}
