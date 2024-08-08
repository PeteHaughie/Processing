#version 410

precision mediump float;

uniform vec2 iResolution;
uniform float iTime;

out vec4 fragColor;

void mainImage( out vec4 O, vec2 u )
{
    vec2 R = iResolution.xy, P,D,
         U = u / R.y, V = 15.*U; V.y += iTime;
    float p = 0.;
    
    for (int k=0; k<9; k++)                            // neighborhood
        P = vec2(float(k%3-1), float(k/3-1)),          // current cell 
        D = fract(1e4*sin(ceil(V-P)*mat2(R.xyyx)))-.5, // node = random offset in cell
        P = fract(V) -.5 + P + D,                      // node relative coordinates
        p += smoothstep(1.3*U.y, 0., length(P));       // its potential

    // p = sqrt(p);
    // p = sin(10.*p); 
    O = vec4((p -.5) / fwidth(p)); // * vec4(.5, .7, 1.2, 1.);
}

void main() {
    mainImage(fragColor, gl_FragCoord.xy);
}
