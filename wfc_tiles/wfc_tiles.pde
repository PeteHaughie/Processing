void setup() {
  size(5, 5);
  background(255);
  fill(0);
  noStroke();
}

void empty() {
  fill(255);
  rect(0, 0, width, height);
  fill(0);
}

void draw() {
  for(int i = 0; i < 13; i++) {
    switch(i) {
      case 0:
        // 0 0 0 0 0
        // 0 0 0 0 0
        // 0 0 0 0 0
        // 0 0 0 0 0
        // 0 0 0 0 0
        saveFrame(i + ".tiff");
        break;
      case 1:
        // 0 0 0 0 0
        // 0 0 0 0 0
        // 1 1 1 1 1
        // 0 0 0 0 0
        // 0 0 0 0 0
        for (int j = 0; j < width; j++) {
          rect(j, 2, 1, 1);
        }
        saveFrame(i + ".tiff");
        break;
      case 2:
        empty();
        // 0 0 1 0 0
        // 0 0 1 0 0
        // 0 0 1 0 0
        // 0 0 1 0 0
        // 0 0 1 0 0
        for (int j = 0; j < height; j++) {
          rect(2, j, 1, 1);
        }
        saveFrame(i + ".tiff");
        break;
      case 3:
        empty();
        // 0 0 1 0 0
        // 0 0 1 0 0
        // 1 1 1 1 1
        // 0 0 1 0 0
        // 0 0 1 0 0
        for (int j = 0; j < height; j++) {
          rect(2, j, 1, 1);
        }
        for (int j = 0; j < width; j++) {
          rect(j, 2, 1, 1);
        }
        saveFrame(i + ".tiff");
        break;
      case 4:
        empty();
        // 0 0 1 0 0
        // 0 0 1 0 0
        // 1 1 1 0 0
        // 0 0 0 0 0
        // 0 0 0 0 0
        for (int j = 0; j < 3; j++) {
          rect(2, j, 1, 1);
        }
        for (int j = 0; j < 3; j++) {
          rect(j, 2, 1, 1);
        }
        saveFrame(i + ".tiff");
        break;
      case 5:
        empty();
        // 0 0 1 0 0
        // 0 0 1 0 0
        // 0 0 1 1 1
        // 0 0 0 0 0
        // 0 0 0 0 0
        for (int j = 0; j < 3; j++) {
          rect(2, j, 1, 1);
        }
        for (int j = 2; j < width; j++) {
          rect(j, 2, 1, 1);
        }
        saveFrame(i + ".tiff");
        break;
      case 6:
        empty();
        // 0 0 0 0 0
        // 0 0 0 0 0
        // 0 0 1 1 1
        // 0 0 1 0 0
        // 0 0 1 0 0
        for (int j = 2; j < height; j++) {
          rect(2, j, 1, 1);
        }
        for (int j = 2; j < width; j++) {
          rect(j, 2, 1, 1);
        }
        saveFrame(i + ".tiff");
        break;
      case 7:
        empty();
        // 0 0 0 0 0
        // 0 0 0 0 0
        // 1 1 1 0 0
        // 0 0 1 0 0
        // 0 0 1 0 0
        for (int j = 2; j < height; j++) {
          rect(2, j, 1, 1);
        }
        for (int j = 0; j < 3; j++) {
          rect(j, 2, 1, 1);
        }
        saveFrame(i + ".tiff");
        break;
      case 8:
        empty();
        // 0 0 0 0 0
        // 0 0 0 0 0
        // 1 1 1 1 1
        // 0 0 1 0 0
        // 0 0 1 0 0
        for (int j = 0; j < width; j++) {
          rect(j, 2, 1, 1);
        }
        for (int j = 2; j < height; j++) {
          rect(2, j, 1, 1);
        }
        saveFrame(i + ".tiff");
        break;
      case 9:
        empty();
        // 0 0 1 0 0
        // 0 0 1 0 0
        // 1 1 1 1 1
        // 0 0 0 0 0
        // 0 0 0 0 0
        for (int j = 0; j < width; j++) {
          rect(j, 2, 1, 1);
        }
        for (int j = 0; j < 3; j++) {
          rect(2, j, 1, 1);
        }
        saveFrame(i + ".tiff");
        break;
      case 10:
        empty();
        // 0 0 1 0 0
        // 0 0 1 0 0
        // 1 1 1 0 0
        // 0 0 1 0 0
        // 0 0 1 0 0
        for (int j = 0; j < 3; j++) {
          rect(j, 2, 1, 1);
        }
        for (int j = 0; j < height; j++) {
          rect(2, j, 1, 1);
        }
        saveFrame(i + ".tiff");
        break;
      case 11:
        empty();
        // 0 0 1 0 0
        // 0 0 1 0 0
        // 0 0 1 1 1
        // 0 0 1 0 0
        // 0 0 1 0 0
        for (int j = 2; j < width; j++) {
          rect(j, 2, 1, 1);
        }
        for (int j = 0; j < height; j++) {
          rect(2, j, 1, 1);
        }
        saveFrame(i + ".tiff");
        break;
      default:
        exit();
    }
  }
}
