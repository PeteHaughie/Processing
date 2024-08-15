import processing.video.*;

PShader pattern;
PShader mixer;

Movie video1;
Movie video2;

PGraphics videoBuffer1;
PGraphics videoBuffer2;
PGraphics patternBuffer;

void setup() {
  size(800, 600, P2D);
  pattern = loadShader("pattern.frag");
  pattern.set("u_time", millis() / 1000.0);
  pattern.set("u_resolution", float(width), float(height));
  mixer = loadShader("mixer.frag");
  videoBuffer1 = createGraphics(800, 600, P2D);
  video1 = new Movie(this, "sun.mp4");
  video1.loop();
  videoBuffer2 = createGraphics(800, 600, P2D);
  video2 = new Movie(this, "seismograph.mp4");
  video2.loop();
  patternBuffer = createGraphics(800, 600, P2D);
}

boolean is_movie_finished(Movie m) {
  return m.duration() - m.time() < 0.05;
}

void update() {
  if (video1.available()) {
    video1.read();
  }
  if (is_movie_finished(video1)) {
    video1.jump(0);
  }
  videoBuffer1.beginDraw();
  videoBuffer1.background(0);
  videoBuffer1.image(video1, 0, 0, 800, 600);
  videoBuffer1.endDraw();
  
  if (video2.available()) {
    video2.read();
  }
  if (is_movie_finished(video2)) {
    video2.jump(0);
  }
  videoBuffer2.beginDraw();
  videoBuffer2.background(0);
  videoBuffer2.image(video2, 0, 0, 800, 600);
  videoBuffer2.endDraw();

  patternBuffer.beginDraw();
  patternBuffer.filter(pattern);
  patternBuffer.endDraw();

  pattern.set("u_time", millis() / 1000.0);
  mixer.set("u_texture1", videoBuffer1);
  mixer.set("u_texture2", videoBuffer2);
  mixer.set("u_texture3", patternBuffer);

  filter(mixer);
}

void draw() {
  update();
}
