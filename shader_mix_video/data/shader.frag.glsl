#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 iResolution;
uniform sampler2D tex1;
uniform sampler2D tex2;
uniform float opacity;

vec4 myMix(vec4 x, vec4 y, float a) {
  return x * (1.0 - a) + y * a;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = vec2(fragCoord.x, fragCoord.y) /iResolution.xy;
    vec4 channel0 = texture2D(tex1, uv.xy);
    vec4 channel1 = texture2D(tex2, uv.xy);
    fragColor = myMix(channel0, channel1, opacity);
}

void main() {
    mainImage( gl_FragColor, gl_FragCoord.xy );
}