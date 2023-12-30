import ddf.minim.*;
import ddf.minim.ugens.*;
import controlP5.*;

Minim minim;
AudioOutput out;
Oscil      wave;
// keep track of the current Frequency so we can display it
Frequency  currentFreq;

PVector location;      // Location of shape
PVector velocity;      // Velocity of shape
PVector gravity;       // Gravity acts at the shape's acceleration
PVector mousePressPos; // Position where the mouse was pressed

int lastCollisionTime = 0;
int debounceDelay = 0; // Delay in milliseconds

ControlP5 cp5;

float outerSize;
float size = 20.;
float damping = 0.995; // Damping factor for each bounce

float sliderValue = size;
float velocityXMultiplier = 1;
float velocityYMultiplier = 1;
Slider abc;

void setup() {
    background(0);
    size(400, 400);
    noStroke();
    fill(255);
    ellipse(outerSize, outerSize, outerSize, outerSize);
    outerSize = width / 2;
    location  = new PVector((width / 2) - 50 + random(100), (height / 2) - 50 + random(100));
    velocity  = new PVector(3.5, 2);
    gravity   = new PVector(0, 0.1);
    minim     = new Minim(this);
    out       = minim.getLineOut();
  
    currentFreq = Frequency.ofPitch( "A4" );
    wave = new Oscil( currentFreq, 0.6f, Waves.TRIANGLE );

    cp5 = new ControlP5(this);

    cp5.addSlider("size")
     .setPosition(20, 20)
     .setRange(size, outerSize)
     ;
    cp5.addSlider("velocityXMultiplier")
     .setPosition(20, 30)
     .setValue(velocityXMultiplier)
     .setRange(1, 5)
     ;
    cp5.addSlider("velocityYMultiplier")
     .setPosition(20, 40)
     .setValue(velocityYMultiplier)
     .setRange(1, 5)
     ;
    cp5.addSlider("damping")
     .setPosition(20, 50)
     .setValue(damping)
     .setRange(0.5, damping)
     ;

      mousePressPos = new PVector(0, 0);

}

void draw() {
    int currentTime = millis();

    // Add velocity to the location.
    location.add(velocity.x * velocityXMultiplier, velocity.y * velocityYMultiplier);

    // Add gravity to velocity
    velocity.add(gravity);

    // Draw the large ellipse 
    fill(255, 255, 255, 25);
    ellipse(outerSize, outerSize, outerSize, outerSize);

    // Check collision with the large ellipse and calculate reflection
    if (dist(location.x, location.y, width / 2, height / 2) > (outerSize / 2 - size / 2)) {
        if (currentTime - lastCollisionTime > debounceDelay) {
          lastCollisionTime = currentTime; // Update the last collision time
          // Correct the position inside the boundary
          float overlap = dist(location.x, location.y, width / 2, height / 2) - (outerSize / 2 - size / 2);
          PVector collisionDirection = PVector.sub(location, new PVector((width - 2) / 2, (height - 2) / 2));
          collisionDirection.normalize();
          collisionDirection.mult(overlap);
          location.sub(collisionDirection);
                    
          // Adjust the reflection based on the collision point
          float angle = atan2(location.y - height / 2, location.x - width / 2);
          
          println(angle * (180 / PI));
          
          if (abs(cos(angle)) > abs(sin(angle))) {
              // Reflect horizontally
              velocity.x *= -1;
          } else {
              // Reflect vertically
              velocity.y *= -1;
          }
  
          if (size <= outerSize) {
            wave.patch( out );
          } else {
            wave.unpatch( out );
          }
  
          // Apply damping
          velocity.mult(damping);
      }
    } else {
      wave.unpatch( out );
    }

    // draw the smaller ellipse
    fill(255, 0, 0);
    ellipse(location.x, location.y, size, size);
}

void keyPressed() {
  if (key == char('s')) {
    saveFrame("####.png");
  }
  if (key == char('r')) {
    location  = new PVector((width / 2) - 50 + random(100), (height / 2) - 50 + random(100));
  }
}

void mousePressed() {
    mousePressPos.x = mouseX;
    mousePressPos.y = mouseY;
}

void mouseReleased() {
    // Calculate angle between press and release positions
    float angle = atan2(mouseY - mousePressPos.y, mouseX - mousePressPos.x);

    // Calculate new velocity based on this angle
    float newVelocityMagnitude = 5; // or some other value
    velocity.x = newVelocityMagnitude * cos(angle);
    velocity.y = newVelocityMagnitude * sin(angle);

    // Set the ellipse's location to the mouse released position for immediate effect
    location.x = mouseX;
    location.y = mouseY;
}
