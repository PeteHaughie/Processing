attribute vec4 position;
attribute vec2 texCoord;
attribute vec4 color;

varying vec4 vertColor;
varying vec2 vertTexCoord;

void main() {
  gl_Position = position;
  vertTexCoord = texCoord;
  vertColor = color;
}
