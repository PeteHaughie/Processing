#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform sampler2D textureSampler;

void main() {
  vec2 uv = gl_FragCoord.xy / u_resolution.xy; // Calculate the UV coordinates
  vec4 texColor = texture(textureSampler, uv); // Sample the texture
  gl_FragColor = texColor; // Output the texture color
}
