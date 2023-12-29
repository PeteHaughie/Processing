// created by florian berger (flockaroo) - 2016
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

// single pass CFD
// ---------------
// this is some "computational flockarooid dynamics" ;)
// the self-advection is done purely rotational on all scales. 
// therefore i dont need any divergence-free velocity field. 
// with stochastic sampling i get the proper "mean values" of rotations 
// over time for higher order scales.
//
// try changing "RotNum" for different accuracies of rotation calculation
//
// "angRnd" is the rotational randomness of the rotation-samples
// "posRnd" is an additional error to the position of the samples (not really needed)
// for higher numbers of "RotNum" "angRnd" can also be set to 0

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 iResolution;
uniform sampler2D iChannel0;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	fragColor = texture2D(iChannel0,uv);
}

void main() {
    mainImage( gl_FragColor, gl_FragCoord.xy );
}
