import websockets.*;

WebsocketClient wsc;

float xoff = 0;
float yoff = 0;
float[] xoffArr;
PGraphics screen1;
PGraphics _screen1;
PGraphics screen2;
PGraphics _screen2;
PGraphics screen3;
PGraphics _screen3;
PImage img;

String str = "No Berlin";
int offset = 50;

color[][] colours = {
  {
    #7E2E84,
    #DE5858,
    #EF798A,
    #FFE987,
    #CCF5AC
  },
  {
    #52A7BC,
    #54DEFD,
    #FFFBFA,
    #00BD9D,
    #8BD7D2
  },
  {
    #F098B9,
    #92BFB1,
    #F4AC45,
    #694A38,
    #A61C3C
  },
  {
    #A9E5BB,
    #FCF6B1,
    #F7B32B,
    #F72C25,
    #833F8C
  },
  {
    #EE6055,
    #60D394,
    #AAF683,
    #FFD97D,
    #FF9B85
  },
  {
    #729EA1,
    #B5BD89,
    #DFBE99,
    #EC9192,
    #DB5375
  },
  {
    #BBD8B3,
    #F3B61F,
    #A29F15,
    #510D0A,
    #191102
  },
  {
    #14342B,
    #60935D,
    #BAB700,
    #BBDFC5,
    #FF579F
  },
  {
    #071E22,
    #1D7874,
    #679289,
    #F4C095,
    #EE2E31
  },
  {
    #857E61,
    #B7A196,
    #DDC3D0,
    #DBDAEA,
    #DBFCFF
  },
  {
    #9BC995,
    #98B9AB,
    #5171A5,
    #3F3047,
    #EEF36A
  },
  {
    #D7FDF0,
    #B2FFD6,
    #B4D6D3,
    #B8BAC8,
    #AA78A6
  },
  {
    #FFCDB2,
    #FFB4A2,
    #E5989B,
    #B5838D,
    #6D6875
  },
  {
    #CCE8CC,
    #F6EFEE,
    #E2B6CF,
    #E396DF,
    #E365C1
  },
  {
    #D4AFB9,
    #D1CFE2,
    #9CADCE,
    #7EC4CF,
    #52B2CF
  },
  {
    #0E7C7B,
    #17BEBB,
    #D4F4DD,
    #D62246,
    #4B1D3F
  },
  {
    #ABE188,
    #F7EF99,
    #F1BB87,
    #F78E69,
    #5D675B
  },
  {
    #D8DCFF,
    #AEADF0,
    #C38D94,
    #A76571,
    #565676
  },
  {
    #FFC1CF,
    #E8FFB7,
    #E2A0FF,
    #C4F5FC,
    #B7FFD8
  },
  {
    #C0BDA5,
    #CC978E,
    #F39C6B,
    #FF3864,
    #261447
  }
};

color[] currentPalette;

// ZMQ
//String ws = "tcp://localhost:3000";
String ws = "ws://degenerativeart.studio:9000";

JSONObject json;

void chooseColours() {
  int palette = int(random(colours.length - 1));
  currentPalette = new color[3]; // Initialize the array to store 3 colours

  for (int i = 0; i < currentPalette.length; ) {
    color potentialColor = colours[palette][int(random(colours[palette].length - 1))];

    // Check if this color is already in the currentPalette
    boolean isUnique = true;
    for (int j = 0; j < i; j++) {
      if (currentPalette[j] == potentialColor) {
        isUnique = false;
        break;
      }
    }

    // If the color is unique, add it to the palette and increment the counter
    if (isUnique) {
      currentPalette[i] = potentialColor;
      i++;
    }
  }
  println("current palette: ", currentPalette[0], currentPalette[1], currentPalette[2]);
}
    

void setup() {
  size(1080, 720);

  wsc = new WebsocketClient(this, ws);
  
  chooseColours();
  
  // display stuff
  noStroke();
  rectMode(CENTER);
  smooth(2);
  img = loadImage("https://fastly.picsum.photos/id/183/1080/720.jpg?hmac=VbSUNsU1XvirtHAvQ9A22ZJ0ZrAxnJYaiz2opkAPlUY");
  screen1 = createGraphics(width / 2, height / 2);
  _screen1 = createGraphics(width / 2, height / 2);
  screen2 = createGraphics(width / 2, height / 2);
  _screen2 = createGraphics(width / 2, height / 2);
  screen3 = createGraphics(width / 2, height / 2);
  _screen3 = createGraphics(width / 2, height / 2);

  xoffArr = new float[width];
    for (int i = 0; i < height ; i++) {
    xoff += 0.05;
    xoffArr[i] = noise(xoff);
  }
}

void updateScreen1() {
  screen1.beginDraw();
  screen1.clear();
  if (str.length() != 0) {
    screen1.textSize(((screen1.width * 2) / str.length()) * 1.5);
    screen1.textLeading(((screen1.width * 2) / str.length()) * 1.5);
    screen1.text(str.toUpperCase(), offset, offset, screen1.width - offset, screen1.height - offset);
  }
  screen1.endDraw();
}

void _updateScreen1() {
  _screen1.beginDraw();
  _screen1.clear();
  for (int i = 0; i < _screen1.width; i++) {
    _screen1.image(screen1.get(i, 0, 1, _screen1.height), i, (noise((i * 0.001) + xoff) * 120));
  }
  _screen1.endDraw();
}

void updateScreen2() {
  screen2.beginDraw();
  screen2.clear();
  if (str.length() != 0) {
    screen2.textSize(((screen2.width * 2) / str.length()) * 1.5);
    screen2.textLeading(((screen2.width * 2) / str.length()) * 1.5);
    screen2.text(str.toUpperCase(), offset, offset, screen2.width - offset, screen2.height - offset);
  }
  screen2.endDraw();
}

void _updateScreen2() {
  _screen2.beginDraw();
  _screen2.clear();
  for (int i = 0; i < _screen2.width; i++) {
    _screen2.image(screen2.get(i, 0, 1, _screen2.height), i, (noise((i * 0.001) + xoff) * 100));
  }
  _screen2.endDraw();
}

void updateScreen3() {
  screen3.beginDraw();
  screen3.image(img, 0, 0);
  screen3.filter(THRESHOLD);
  screen3.endDraw();
}

void _updateScreen3() {
  _screen3.beginDraw();
  _screen3.noStroke();
  for (int y = 0; y < _screen3.height; y++) {
    for (int x = 0; x < _screen3.width; x++) {
      color c = color(screen3.get(x, y));
      if (brightness(c) > 0) {
        _screen3.ellipse(x, y, 3, 3);
      }
    }
  }
  _screen3.fill(c2);
  _screen3.endDraw();
}

color c1;
color c2;
color c3;

void draw() {
  c1 = currentPalette[0];
  c2 = currentPalette[1];
  c3 = currentPalette[2];
  background(c1);
  noStroke();
  
  updateScreen1();
  _updateScreen1();
  
  updateScreen2();
  _updateScreen2();
  
  updateScreen3();
  _updateScreen3();

  xoff += 0.01;

  //for (int i = 0; i < width; i++) {
  //  image(
  //    _screen3.get(0, i, height, 1), // src
  //    (noise((i * 0.001) + xoff) * 125) - (width / 2), // x
  //     (i - (height / 2)) + (noise((i * 0.005) + xoff) * 100) // y
  //  );
  //}
  image(img, 0, 0, width, height);

  for (int y = 0; y < _screen1.height; y++) {
    for (int x = 0; x < _screen1.width; x++) {
      color c = color(_screen1.get(x, y));
      if (brightness(c) > 0) {
        ellipse(x, y, 3, 3);
        fill(c3);
      }
    }
  }

  for (int y = 0; y < _screen2.height; y++) {
    for (int x = 0; x < _screen2.width; x++) {
      color c = color(_screen2.get(x, y));
      if (brightness(c) > 0) {
        ellipse(x, y, 3, 3);
        fill(c3);
      }
    }
  }
}

void keyPressed() {
  if (key == char('s')) {
    save("output.png");
  }
  if (key == char('w')) {
    chooseColours();
  }
}

void webSocketEvent(String msg){
  json = parseJSONObject(msg);
  if (json.isNull("text") == false) {
     println(json.getString("text"));
     str = json.getString("text");
  }
  if (json.isNull("file") == false) {
     println(json.getString("file"));
     img = loadImage("http://degenreativeart.studio:9000/uploads/" + json.getString("file"));
  }
}
