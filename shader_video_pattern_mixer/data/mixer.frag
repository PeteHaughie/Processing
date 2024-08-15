#version 410

#ifdef GL_ES
precision mediump float;
#endif

out vec4 outputColor;

uniform sampler2D u_texture1;
uniform sampler2D u_texture2;
uniform sampler2D u_texture3; // This is the mask texture

// This function takes in three textures and mixes them based on the value of tex3Color.r
void mixer(out vec4 outputColor, vec2 pixelCoords) {
  vec2 uv = pixelCoords / vec2(textureSize(u_texture1, 0)); // Normalized coordinates

  vec4 tex1Color = texture(u_texture1, uv);
  vec4 tex2Color = texture(u_texture2, uv);
  vec4 tex3Color = texture(u_texture3, uv);

  if (tex3Color.r < 0.5) {
    outputColor = tex2Color;
  } else {
    outputColor = tex1Color;
  }
}

void main() {
  mixer(outputColor, gl_FragCoord.xy);
}