import processing.video.*;

Capture cam;

PImage trinity;
PGraphics screen;
PGraphics camera;

int cellSize = 10;
boolean showDetails = false;
boolean rotate = false;
int blurVal = 0;
int line = cellSize;
int source = 0;

void setup() {
  size( 1280, 720, P3D );
  colorMode(HSB);
  noFill();
  screen = createGraphics(width / cellSize, height / cellSize);
  cam = new Capture(this, width / cellSize, height / cellSize);
  cam.start();
  changeSource();
}

void changeSource() {
  screen.beginDraw();
  if (source == 0) {
    cam.stop();
    trinity = loadImage( "trinity_test.jpg" );
    trinity.resize( width / cellSize, height / cellSize );
    screen.image(trinity, 0, 0);
  }
  if (source == 1) {
    if ( cam.available() ) {
      screen.image(camera, 0, 0);
    }
  }
  screen.endDraw();
}

void draw() {
  changeSource();
  background(0);
  push();
  translate( width / 2, 0 );
  if (rotate) {
    rotateY( radians( frameCount ) );
  }
  push();
  translate( - ( width / 2 ), 0);
  for ( int y = 0; y < ( height / cellSize ); y++ ) {
    beginShape();
    for ( int x = 0; x < ( width / cellSize ); x++ ) {
      screen.loadPixels();
      color c = screen.pixels[x + y * ( width / cellSize )];
      stroke( c );
      strokeWeight( line );
      push();
      vertex( cellSize * x, cellSize * y, map( brightness( c ), 0, 255, 0, 255 ) );
      pop();
    }
    endShape();
  }
  pop();
  filter( BLUR, blurVal );
  pop();
  if (showDetails) {
    hint(DISABLE_DEPTH_MASK);
    image(screen, 10, 10);
  }
}

void keyPressed() {
  //println( keyCode );
  // cursor up 38
  // cursor down 40
  // cursor left 37
  // cursor right 39

  // toggle overlay with with w
  if ( keyCode == 87 ) {
    showDetails = !showDetails;
  }

  // toggle rotate with with r
  if ( keyCode == 82 ) {
    rotate = !rotate;
  }

  // quit with q
  if ( keyCode == 81 ) {
    exit();
  }
  
  // change source with s
  if ( keyCode == 83 ) {
    if ( source >= 2) {
      source = 0;
    } else {
      source += 1; 
    }
  }
  
  // increase the line distance with e
  if ( keyCode == 69 ) {
    if ( line >= cellSize ) {
      line = 0;
    } else {
      line += 1;
    }
  }

  // toggle blur with a
  if ( keyCode == 65 ) {
    if ( blurVal >= 3 ) {
      blurVal = 0;
    } else {
      blurVal += 1;
    }
  }
}
