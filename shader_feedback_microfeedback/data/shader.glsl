// Fork of "Cartoon/ComicBook FX" by snakebyteme2. https://shadertoy.com/view/XtSfW1
// 2020-03-25 02:25:40
// change textureSize to iChannelResolution

#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D iChannel0;
uniform vec2 iResolution;

#define T(x) texture2D(iChannel0, fract((x)/iResolution.xy))

void mainImage(out vec4 c, vec2 u)
{   
    //c=1./u.yyyx;
    c=u.yyyx/1e4;///iTime;
    for(float t=1.4; t<1e2; t+=t)
       c += (c.gbar-c)/3.+T(u-c.wz*t);
    // for(float t=.6; t<4e2; t+=t)
    // 	c += c.gbar/4.-c*.3+T(u-c.wz*t);
    
	c = mix(T(u+c.xy), cos(c), .07);
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
