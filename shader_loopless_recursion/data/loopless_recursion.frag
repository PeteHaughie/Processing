#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec2 iResolution;
uniform float iTime;
uniform sampler2D iChannel0;

/*
    "Loopless Recursion" by @XorDev

    I've seen some examples with a recursive screen loop effect (shadertoy.com/view/MfBczR)
    and I wanted to try without using a for-loop or multiple texture samples.

    This method only handles scaling, so no rotation, but I imagine rotation could be possible within reasonable bounds
    The idea here is to map the coordinates to a logarithmic scale, cut it into steps and then map it back to linear scale.
*/

void mainImage(out vec4 O, vec2 I)
{
    //Center screen uv coordinates (-0.5 to +0.5)
    vec2 u = I/iResolution.xy-.5,

    //Oscillate the scaling factor
    s = exp(sin(iTime+u-u)*2.);

    //Sample texture
    O = texture2D(iChannel0,

    //u*u for absolute coordinates (countered by multiplying the log by 0.5)
    //max: Use the longest axis for the box boundaries and scale it.
    //ceil: Break coordinates into steps
    //exp: Remap back to linear scale and center it to the 0 to 1 range.
    u*.5/exp(ceil(s*log(max(u*=u,u.yx))*.5)/s)+.5);
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
