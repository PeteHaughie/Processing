// An implementation of the easing animations from easings.net in JS for P5

// Define the easing functions
// Sine
float easeInSine(float x) {
  return 1 - cos((x * PI) / 2);
}

float easeOutSine(float x) {
  return sin((x * PI) / 2);
}

float easeInOutSine(float x) {
  return -(cos(PI * x) - 1) / 2;
}

// Cubic
float easeInCubic(float x) {
  return x * x * x;
}

float easeOutCubic(float x) {
  return 1 - pow(1 - x, 3);
}

float easeInOutCubic(float x) {
  return x < 0.5 ? 4 * x * x * x : 1 - pow(-2 * x + 2, 3) / 2;
}

// Quint
float easeInQuint(float x) {
  return x * x * x * x * x;
}

float easeOutQuint(float x) {
  return 1 - pow(1 - x, 5);
}

float easeInOutQuint(float x) {
  return x < 0.5 ? 16 * x * x * x * x * x : 1 - pow(-2 * x + 2, 5) / 2;
}

// Circ
float easeInCirc(float x) {
  return 1 - sqrt(1 - pow(x, 2));
}

float easeOutCirc(float x) {
  return sqrt(1 - pow(x - 1, 2));
}

float easeInOutCirc(float x) {
  return x < 0.5
    ? (1 - sqrt(1 - pow(2 * x, 2))) / 2
    : (sqrt(1 - pow(-2 * x + 2, 2)) + 1) / 2;
}

// Elastic
float easeInElastic(float x) {
  float c4 = (2 * PI) / 3;

  return x == 0
    ? 0
    : x == 1
    ? 1
    : -pow(2, 10 * x - 10) * sin((x * 10 - 10.75) * c4);
}

float easeOutElastic(float x) {
  float c4 = (2 * PI) / 3;

  return x == 0
    ? 0
    : x == 1
    ? 1
    : pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1;
}

float easeInOutElastic(float x) {
  float c5 = (2 * PI) / 4.5;

  return x == 0
    ? 0
    : x == 1
    ? 1
    : x < 0.5
    ? -(pow(2, 20 * x - 10) * sin((20 * x - 11.125) * c5)) / 2
    : (pow(2, -20 * x + 10) * sin((20 * x - 11.125) * c5)) / 2 + 1;
}

// Quad
float easeInQuad(float x) {
  return x * x;
}

float easeOutQuad(float x) {
  return 1 - (1 - x) * (1 - x);
}

float easeInOutQuad(float x) {
  return x < 0.5 ? 2 * x * x : 1 - pow(-2 * x + 2, 2) / 2;
}

// Quart
float easeInQuart(float x) {
  return x * x * x * x;
}

float easeOutQuart(float x) {
  return 1 - pow(1 - x, 4);
}

float easeInOutQuart(float x) {
  return x < 0.5 ? 8 * x * x * x * x : 1 - pow(-2 * x + 2, 4) / 2;
}

// Expo
float easeInExpo(float x) {
  return x == 0 ? 0 : pow(2, 10 * x - 10);
}

float easeOutExpo(float x) {
  return x == 1 ? 1 : 1 - pow(2, -10 * x);
}

float easeInOutExpo(float x) {
  return x == 0
    ? 0
    : x == 1
    ? 1
    : x < 0.5 ? pow(2, 20 * x - 10) / 2
    : (2 - pow(2, -20 * x + 10)) / 2;
}

// Back
float easeInBack(float x) {
  float c1 = 1.70158;
  float c3 = c1 + 1;

  return c3 * x * x * x - c1 * x * x;
}

float easeOutBack(float x) {
  float c1 = 1.70158;
  float c3 = c1 + 1;

  return 1 + c3 * pow(x - 1, 3) + c1 * pow(x - 1, 2);
}

float easeInOutBack(float x) {
  float c1 = 1.70158;
  float c2 = c1 * 1.525;

  return x < 0.5
    ? (pow(2 * x, 2) * ((c2 + 1) * 2 * x - c2)) / 2
    : (pow(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2;
}

// Bounce
float easeInBounce(float x) {
  return 1 - easeOutBounce(1 - x);
}

float easeOutBounce(float x) {
  float n1 = 7.5625;
  float d1 = 2.75;

  if (x < 1 / d1) {
      return n1 * x * x;
  } else if (x < 2 / d1) {
      return n1 * (x -= 1.5 / d1) * x + 0.75;
  } else if (x < 2.5 / d1) {
      return n1 * (x -= 2.25 / d1) * x + 0.9375;
  } else {
      return n1 * (x -= 2.625 / d1) * x + 0.984375;
  }
}

float easeInOutBounce(float x) {
  return x < 0.5
    ? (1 - easeOutBounce(1 - 2 * x)) / 2
    : (1 + easeOutBounce(2 * x - 1)) / 2;
}

// Define some variables to control the animation
float startTime;
int dur = 1000; // 1 second
float startX = 0;
float nextX = 0;
float endX = 0;
float prevX = 0;
float currX = 0;
boolean animating = false;

void setup() {
  size(400, 400);
  startTime = millis();
}

void draw() {
  // Calculate the elapsed time since the animation started
  float elapsedTime = millis() - startTime;

  // Calculate the progress of the animation as a value between 0 and 1
  float progress = min(elapsedTime / dur, 1);

  // Calculate the next position of the circle using the easing function
  // Sine
  // nextX = lerp(prevX, endX, easeInSine(progress));
  // nextX = lerp(prevX, endX, easeOutSine(progress));
  // nextX = lerp(prevX, endX, easeInOutSine(progress));
  // Cubic
  // nextX = lerp(prevX, endX, easeInCubic(progress));
  // nextX = lerp(prevX, endX, easeOutCubic(progress));
  // nextX = lerp(prevX, endX, easeInOutCubic(progress));
  // Quint
  // nextX = lerp(prevX, endX, easeInQuint(progress));
  // nextX = lerp(prevX, endX, easeOutQuint(progress));
  // nextX = lerp(prevX, endX, easeInOutQuint(progress));
  // Circ
  // nextX = lerp(prevX, endX, easeInCirc(progress));
  // nextX = lerp(prevX, endX, easeOutCirc(progress));
  // nextX = lerp(prevX, endX, easeInOutCirc(progress));
  // Elastic
  // nextX = lerp(prevX, endX, easeInElastic(progress));
  // nextX = lerp(prevX, endX, easeOutElastic(progress));
  nextX = lerp(prevX, endX, easeInOutElastic(progress));
  // Quad
  // nextX = lerp(prevX, endX, easeInQuad(progress));
  // nextX = lerp(prevX, endX, easeOutQuad(progress));
  // nextX = lerp(prevX, endX, easeInOutQuad(progress));
  // Quart
  // nextX = lerp(prevX, endX, easeInQuart(progress));
  // nextX = lerp(prevX, endX, easeOutQuart(progress));
  // nextX = lerp(prevX, endX, easeInOutQuart(progress));
  // Expo
  // nextX = lerp(prevX, endX, easeInExpo(progress));
  // nextX = lerp(prevX, endX, easeOutExpo(progress));
  // nextX = lerp(prevX, endX, easeInOutExpo(progress));
  // Back
  // nextX = lerp(prevX, endX, easeInBack(progress));
  // nextX = lerp(prevX, endX, easeOutBack(progress));
  // nextX = lerp(prevX, endX, easeInOutBack(progress));
  // Bounce
  // nextX = lerp(prevX, endX, easeInBounce(progress));
  // nextX = lerp(prevX, endX, easeOutBounce(progress));
  // nextX = lerp(prevX, endX, easeInOutBounce(progress));

  // Draw the circles at the current and next positions
  background(220);
  fill(0, 0, 255);
  circle(prevX, height / 2, 10);
  fill(255, 0, 0);
  circle(currX, height / 2, 10);
  fill(0, 255, 0);
  circle(nextX, height / 2, 10);

  // If the animation is complete, reset the start time and positions
  if (progress == 1 && endX != currX && animating) {
    startTime = millis();
    prevX = currX;
    currX = nextX;
    animating = false;
  }
}

void mouseClicked() {
  if (!animating) {
    endX = mouseX;
    animating = true;
  }
}
