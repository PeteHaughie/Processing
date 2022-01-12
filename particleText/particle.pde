class Particle {
  PVector origin;
  PVector destination;
  PVector velocity;
  float x;
  float y;
  float ballYPos;
  float currentBallPos;
  float ballSize;
  float ballRadius;
  float particleRadius;
  float distance;
  float speed;
  Particle() {
    x = 0;
    y = 0;
    ballYPos = 0;
    currentBallPos = 0;
    ballSize = 0;
    ballRadius = 0;
    particleRadius = ballRadius;
    distance = 0;
    origin = new PVector(x, y);
    destination = new PVector(x, y);
    velocity = new PVector(x, y);
  }

  void all(float wave, float size, float ypos) {
    update(wave, size, ypos);
    collision();
    display();
  }

  void collision() {
    // check x and y collision of wave ellipse and particle ellipse
    distance = dist(destination.x, destination.y, currentBallPos, ballYPos);
    if (distance < ballSize) {
      if (destination.y >= ballYPos) {
        velocity.y = -ballSize;
      } else {
        velocity.y = ballSize;
      }
    }
  }

  void update(float wave, float size, float ypos) {
    // where is the particle?
    destination.x = origin.x + velocity.x;
    destination.y = origin.y + velocity.y;
    // how big is the ball?
    ballSize = size;
    // where is the ball?
    ballYPos = ypos;
    currentBallPos = wave;
    if (velocity.y > 0)  {
      velocity.y -= 0.7;
    }
    if (velocity.y < 0)  {
      velocity.y += 0.7;
    }
  }

  void display() {
    fill(0, 0, 0);
    noStroke();
    ellipse(destination.x, destination.y, 2, 2);
  }
}
