#ifdef GL_ES
precision mediump float;
#endif

uniform vec2  u_resolution;
uniform float u_time;
uniform vec3  u_color;

void main(){
  vec2 coord = gl_FragCoord.xy / u_resolution;

  vec3 color = vec3(sin(u_time * u_color.x), cos(u_time * u_color.y), sin(u_time * u_color.z));

  gl_FragColor = vec4(color, 1);
}