void ResizeImage(PImage img) {
  
  PVector dim;
  dim = new PVector();
  dim.x = img.width;
  dim.y = img.height;
  float aspect = Math.min(width / dim.x, height / dim.y);
  img.resize(floor(dim.x * aspect) + floor(width - (dim.x * aspect)), floor(dim.y * aspect) + floor(width - (dim.x * aspect)));
}
