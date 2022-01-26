void ResizeImage(PImage img) {
  
  PVector dim;
  dim = new PVector();
  dim.x = img.width;
  dim.y = img.height;
      
  float aspect = Math.min(width / dim.x, height / dim.y);
  
  img.resize(ceil((image.width / aspect) / 10), ceil((image.height / aspect) / 10));
}
