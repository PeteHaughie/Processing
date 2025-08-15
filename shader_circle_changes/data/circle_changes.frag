#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec2 iResolution;
uniform float iTime;

float sdCircle( vec2 p, float r )
{
    return length(p) - r;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (2.0*fragCoord - iResolution.xy)/iResolution.y;
    vec3 col  = vec3(0.094, 0.655, 0.667);
    vec3 colPlane = vec3(0.094,0.267,0.667);
    float r = 0.8;
    float k = 0.05 * abs(sin(5.0*iTime + 1.5*uv.x*uv.y*(uv.x + uv.y)));
    col = mix(col, vec3(col.z, col.y, col.x), 2.0*k);
    colPlane = mix(colPlane, vec3(colPlane.z, colPlane.y, colPlane.x), 5.0*k);
    float circle =  sdCircle(uv, k);
    
    float stepCircle = smoothstep(r, r + 0.02, circle);
    col = mix(col, colPlane, stepCircle);
    fragColor = vec4(col,1.0);
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
