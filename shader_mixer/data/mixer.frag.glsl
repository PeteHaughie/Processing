#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;

uniform sampler2D tex0;
uniform sampler2D tex1;
uniform sampler2D tex2;
uniform sampler2D tex3;

uniform float opacityx;
uniform float opacityy;

vec4 myMix(vec4 x, vec4 y, float a) {
  return x * (1.0 - a) + y * a;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = vec2(fragCoord.x, resolution.y - fragCoord.y) / resolution.xy;
  vec4 channel0 = texture2D(tex0, uv.xy);
       channel0.rgb *= opacityx;
  vec4 channel1 = texture2D(tex1, uv.xy);
       channel1.rgb *= 1 - opacityx;
  vec4 channel2 = texture2D(tex2, uv.xy);
       channel2.rgb *= opacityy;
  vec4 channel3 = texture2D(tex3, uv.xy);
       channel3.rgb *= 1 - opacityy;
  // Blend pairs of textures
  vec4 blend01 = myMix(channel0, channel1, 0.5); // Adjust the blend factor as needed
  vec4 blend23 = myMix(channel2, channel3, 0.5); // Adjust the blend factor as needed

  // Blend the results of the first blends
  fragColor = myMix(blend01, blend23, 0.5); // Adjust the final blend factor as needed
}

void main() {
  mainImage(gl_FragColor, gl_FragCoord.xy);
}
