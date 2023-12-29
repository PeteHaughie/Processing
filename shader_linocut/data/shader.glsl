#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 iResolution;
uniform sampler2D iChannel0;

float luma(vec3 color) {
  return dot(color, vec3(0.299, 0.587, 0.114));
}

float luma(vec4 color) {
  return dot(color.rgb, vec3(0.299, 0.587, 0.114));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 center = vec2(iResolution.x/2., iResolution.y/2.);
    vec2 uv = fragCoord.xy;
    
    float scale = 1.;
    float radius = .5;
    vec2 d = uv - center;
    float r = length(d)/1000.;
    float a = atan(d.y,d.x) + scale*(radius-r)/radius;
    //a += .1 * iTime;
    vec2 uvt = center+r*vec2(cos(a),sin(a));
    
	vec2 uv2 = fragCoord.xy / iResolution.xy;
    float c = ( .75 + .25 * sin( uvt.x * 1000. ) );
    vec4 color = texture2D( iChannel0, uv2 );
    float l = luma( color );
    float f = smoothstep( .5 * c, c, l );
	f = smoothstep( 0., .5, f );
    
	fragColor = vec4( vec3( f ),.0);
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}