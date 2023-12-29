PShader myShader;
PImage test;
PImage dither;
PImage palette;

void setup() {
    size(256, 256, P2D);
    myShader = loadShader("shader.frag");
    test = loadImage("test.png");
    dither = loadImage("dither_matrix.png");
    palette = loadImage("palette_eeve.png");
    myShader.set("u_resolution", (float) width, (float) height);
    myShader.set("u_bit_depth", 16);
    myShader.set("u_contrast", 1);
    myShader.set("u_offset", 0);
    myShader.set("u_dither_size", 10);
    myShader.set("u_texture", test);
    myShader.set("u_texture_size", (float) test.width, (float) test.height);
    myShader.set("u_dither_tex", dither);
    myShader.set("u_dither_tex_size", (float) dither.width, (float) dither.height);
    myShader.set("u_color_tex", palette);
    myShader.set("u_color_tex_size", (float) palette.width, (float) palette.height);
}

void draw() {
    filter(myShader);
}
