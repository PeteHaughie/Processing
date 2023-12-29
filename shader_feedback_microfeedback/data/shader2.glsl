#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D iChannel0;

void mainImage(out vec4 c, vec2 u)
{
    c = .5+.5*texelFetch(iChannel0, ivec2(u),0);
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
