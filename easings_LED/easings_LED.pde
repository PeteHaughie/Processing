// A float version of the internal map function from https://forum.arduino.cc/t/arduino-map-function-for-float-values/112888/5
static float mapf(float x, float in_min, float in_max, float out_min, float out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

// A series of easing functions from https://easings.net/

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

// make an array of the easing functions
float applyEasings(String easingName, float t) {
  switch (easingName) {
    case "easeInCirc":
      return easeInCirc(t); 
    case "easeOutCirc":
      return easeOutCirc(t); 
    case "easeInOutCirc":
      return easeInOutCirc(t); 
    case "easeInElastic":
      return easeInElastic(t); 
    case "easeOutElastic":
      return easeOutElastic(t); 
    case "easeInOutElastic":
      return easeInOutElastic(t);
    case "easeInQuad":
      return easeInQuad(t); 
    case "easeOutQuad":
      return easeOutQuad(t); 
    case "easeInOutQuad":
      return easeInOutQuad(t); 
    case "easeInQuart":
      return easeInQuart(t); 
    case "easeOutQuart":
      return easeOutQuart(t);
    case "easeInOutQuart":
      return easeInOutQuart(t);
    case "easeInExpo":
      return easeInExpo(t); 
    case "easeOutExpo":
      return easeOutExpo(t); 
    case "easeInOutExpo":
      return easeInOutExpo(t); 
    case "easeInBounce":
      return easeInBounce(t);
    case "easeOutBounce":
      return easeOutBounce(t);
    case "easeInOutBounce":
      return easeInOutBounce(t);
    default:
      return t; // Default to linear easing if easing function not found
  }
}

String easings[] = {
  "easeInSine",
  "easeOutSine",
  "easeInOutSine",
  "easeInCubic",
  "easeOutCubic",
  "easeInOutCubic",
  "easeInQuint",
  "easeOutQuint",
  "easeInOutQuint",
  "easeInCirc",
  "easeOutCirc",
  "easeInOutCirc",
  "easeInElastic",
  "easeOutElastic",
  "easeInOutElastic",
  "easeInQuad",
  "easeOutQuad",
  "easeInOutQuad",
  "easeInQuart",
  "easeOutQuart",
  "easeInOutQuart",
  "easeInExpo",
  "easeOutExpo",
  "easeInOutExpo",
  "easeInBounce",
  "easeOutBounce",
  "easeInOutBounce"
};

// Define some variables to control the animation
float startTime;
int dur = 1000; // 1 seconds
float amt = 0;
float startAmt = 0;
float endAmt = 1;
int index = 0;
boolean pingpong = false;

void setup() {
  size(600, 600);
  background(0);
  noStroke();
  startTime = millis();
}

void draw() {
  background(0);
  float elapsedTime = millis() - startTime;
  float t = min(elapsedTime / dur, 1);
  t = applyEasings(easings[index], t); // Apply easing
  amt = lerp(startAmt, endAmt, t); // Interpolate between startAmt and endAmt
  float LED_Val = mapf(amt, 0, 1, 0, 255);
  fill(255, 0, 0, LED_Val);
  fill(255, 0, 0, LED_Val);
  circle(width / 2, height / 2, 20);
  if (t >= 1) {
    startTime = millis();
    
    if (index < easings.length - 1) {
      index += 1;
      if (index % 2 == 0) {
        startAmt = 0;
        endAmt = 1;
      } else {
        startAmt = 1;
        endAmt = 0;
      }
    } else {
      index = 0;
      startAmt = 0;
      endAmt = 1;
    }
  }
}
