PShape venus;
PGraphics buffer;
PVector centerOffset;

void setup() {
  size(480, 360, P3D);
  venus = loadShape("venus.obj");
  venus.disableStyle();
  buffer = createGraphics(width, height, P3D);

  centerOffset = computeCenter(venus);
}

void draw() {
  buffer.beginDraw();
  buffer.clear();
  buffer.background(255, 207, 234);
  buffer.lights();
  buffer.fill(175, 233, 255);

  buffer.pushMatrix();
  buffer.translate(width / 2, height / 2 - 20, -280); // move pivot to screen center
  buffer.rotateY(radians(frameCount % 360));     // spin
  buffer.rotateX(radians(180));                  // flip
  buffer.scale(175);
  buffer.translate(-centerOffset.x, -centerOffset.y, -centerOffset.z); // recenter pivot
  buffer.shape(venus);
  buffer.popMatrix();

  buffer.endDraw();
  image(buffer, 0, 0, width, height);
  if (frameCount < 360)
    saveFrame("output/###.png");
  else
    exit();
}

PVector computeCenter(PShape s) {
  float minX = Float.MAX_VALUE, minY = Float.MAX_VALUE, minZ = Float.MAX_VALUE;
  float maxX = -Float.MAX_VALUE, maxY = -Float.MAX_VALUE, maxZ = -Float.MAX_VALUE;

  int childCount = s.getChildCount();
  if (childCount == 0) {
    for (int i = 0; i < s.getVertexCount(); i++) {
      PVector v = s.getVertex(i);
      minX = min(minX, v.x);
      minY = min(minY, v.y);
      minZ = min(minZ, v.z);
      maxX = max(maxX, v.x);
      maxY = max(maxY, v.y);
      maxZ = max(maxZ, v.z);
    }
  } else {
    for (int c = 0; c < childCount; c++) {
      PShape child = s.getChild(c);
      for (int i = 0; i < child.getVertexCount(); i++) {
        PVector v = child.getVertex(i);
        minX = min(minX, v.x);
        minY = min(minY, v.y);
        minZ = min(minZ, v.z);
        maxX = max(maxX, v.x);
        maxY = max(maxY, v.y);
        maxZ = max(maxZ, v.z);
      }
    }
  }

  return new PVector(
    (minX + maxX) / 2.0,
    (minY + maxY) / 2.0,
    (minZ + maxZ) / 2.0
  );
  }
