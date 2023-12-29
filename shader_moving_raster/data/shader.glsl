// Fork of "Cartoon/ComicBook FX" by snakebyteme2. https://shadertoy.com/view/XtSfW1
// 2020-03-25 02:25:40
// change textureSize to iChannelResolution

#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D iChannel0;
uniform vec2 iResolution;
uniform float iTime;

void mainImage(out vec4 o, vec2 U) {
    o-=o;
    vec2 u = U/iResolution.xy;
    o += step( 1.1 - texture(iChannel0, u).r, fract(3.*iTime-u.y*30.) );
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
