#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D buffer;
uniform vec2 uResolution;
uniform float uGlobalTime;

void main(void) {
	vec2 uv = gl_FragCoord.xy / uResolution.xy;
    vec2 coord = uv + vec2(0.05, 0.05);
    coord = fract(coord);
    vec4 colour = texture2D(buffer, uv);
	gl_FragColor = colour;
}