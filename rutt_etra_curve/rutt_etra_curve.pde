import processing.video.*;

// instantiate objects
PImage trinity;
PGraphics screen;
Capture cap;

// globals
int gridSize = 10;
boolean show_gui = false;
boolean iso = false;
int xRotation = 0;
int yRotation = 0;
int zRotation = 0;


void setup() {
  size( 960, 540, P3D );
  noFill();
  //ortho();
  //cap = new Capture( this, width, height );
  //cap.start();  
  screen = createGraphics( width / gridSize, height / gridSize );
  trinity = loadImage("trinity_test.jpg");
  screen.beginDraw();
  screen.image(trinity, 0, 0, screen.width, screen.height);
  screen.endDraw();
}

void draw() {
  background( 0 );
  strokeWeight( gridSize );
  if (iso)
    ortho();
  else
    perspective();
  //if (cap.available()) {
  //  cap.read();
  //  screen.beginDraw();
  //  screen.background(255);
  //  //screen.filter(GRAY);
  //  screen.image( cap, 0, 0, screen.width, screen.height );
  //  screen.endDraw();
    screen.loadPixels();
    translate( width / 2, height / 2, 0 );
    push();
    translate( - ( width / 2 ), - ( height / 2 ), - height );
    for ( int y = 0; y < screen.height; y++ ) {
      beginShape();
      float comparison[] = {0, 0};
      for ( int x = 0; x < screen.width; x++ ) {
        color c = screen.pixels[x + y * screen.width];
        float brightness = brightness( c );
        if (brightness > comparison[ 0 ]) {
          comparison[ 0 ] = brightness;
          comparison[ 1 ] = x;
        }
      }
      for ( int x = 0; x < screen.width; x++ ) {
        // comparison variables - compare current to stored and position
        color c = screen.pixels[x + y * screen.width];
        stroke( c );
        float brightness = brightness( c );
        //if ( comparison[ 1 ] < x ) {
        //  stroke( brightness( (int) abs( comparison[ 0 ] ) * 255 ) );
        //  curveVertex( gridSize * x, gridSize * y, brightness( (int) abs( ( 255 * comparison[ 0 ] ) ) - ( int ) abs( noise( x + y * screen.width ) * x ) * 50 ) );
        //} else {
        //  curveVertex( gridSize * x, gridSize * y, brightness );
        //}
        curveVertex( gridSize * x, gridSize * y, brightness );
      }
      endShape();
    }
    pop();
  
    translate( -( width / 2 ), -( height / 2 ) );
    if ( show_gui ) {
      hint( DISABLE_DEPTH_TEST );
      image( screen, 10, 10 );
    }
  //}
}

void keyPressed() {
  if ( key == char('q') ) {
    exit();
  }
  
  if ( key == char('w') ) {
    show_gui = !show_gui;
  }

  if ( key == char('e') ) {
    iso = !iso;   
  }
  
}
