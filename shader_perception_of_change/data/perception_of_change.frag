#version 410

precision mediump float;

uniform sampler2D iChannel0;
uniform vec2 iResolution;
uniform vec3 iMouse;
uniform float iTime;

out vec4 fragColor;

// based on https://www.shadertoy.com/view/ltjXWW
// PS: this is just a sketch of test: noise is too low quality as it is.

#define L  20.
#define R(a) mat2(cos(a),sin(a),-sin(a),cos(a)) // rot
float T;                                        // B(): base noise
#define B(u) ( 1. - abs( 2.* texture(iChannel0, (u)/1e3 ).r - 1.) )

float N(vec2 u) { // infinite perlin noise with constant image-space spectrum (like Shepard scale)
	mat2 M = R(1.7);                            // to decorelate layers
    float v = 0., t = 0.;
	for (float i=0.; i<L; i++)                  // loop on harmonics
	{   float k = mod(i-T,L),
		      a = 1.-cos(6.28*k/L),             // enveloppe
		      s = exp2(k);                      // fractal noise spectrum
		v += a/s * B(M*u*s); 
		t += a/s;  M *= M;
	}
    return v/t;
}

void mainImage( out vec4 O, vec2 U ) {
	vec2  R = iResolution.xy; 
          U = (U-.5*R)/R.y;
    T = 1.5 * iTime;
    float e = .5 * iMouse.y/R.y;                  // tunes transition
    // float e = U.x < 0. ? 0. : .03;
    
    O = vec4( sqrt(smoothstep(.7-e,.7+e, N(U) )) );  // sqrt approximates gamma 1./2.2
}                                               // .7 because of interp ( otherwise .5 )

void main() {
    mainImage(fragColor, gl_FragCoord.xy);
}
