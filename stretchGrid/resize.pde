void ResizeImage(PImage img) {
  
  PVector dim;
  dim = new PVector();
  dim.x = img.width;
  dim.y = img.height;
  float aspect = Math.min(width / dim.x, height / dim.y);
  img.resize(floor(dim.x * aspect) + floor(width - (dim.x * aspect)), floor(dim.y * aspect) + floor(width - (dim.x * aspect)));
}

void ResizeImage(PImage img, int scale) {
  
  PVector dim;
  dim = new PVector();
  dim.x = img.width;
  dim.y = img.height;
  float aspect = Math.min(scale / dim.x, scale / dim.y);
  img.resize(floor(dim.x * aspect) + floor(scale - (dim.x * aspect)), floor(dim.y * aspect) + floor(scale - (dim.x * aspect)));
}
