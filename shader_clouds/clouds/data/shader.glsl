#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 iResolution;
uniform vec2 iMouse;
uniform float iTime;
uniform sampler2D iChannel0;

mat2 rot(in float a){float c = cos(a), s = sin(a);return mat2(c,s,-s,c);}
const mat3 m3 = mat3(0.33338, 0.56034, -0.71817, -0.87887, 0.32651, -0.15323, 0.15162, 0.69596, 0.61339)*1.93;

vec2 disp(float t){ return vec2(sin(t*0.22), cos(t*0.175))*2.; }

vec2 map(vec3 p)
{
    p.xy *= rot(iTime*0.09);
    float cl = dot(p.xy, p.xy);
    float d = 0.;
    float z = 1.;
    for(int i = 0; i < 3; i++) // Reduced iterations
    {
        p += sin(p.zxy*0.75 + iTime*.8)*0.1; // Reduced complexity
        d -= abs(dot(cos(p), sin(p.yzx))*z);
        z *= 0.57;
        p = p * m3;
    }
    d = abs(d) - 2.5;
    return vec2(d + cl*.2 + 0.25, cl);
}

vec4 render( in vec3 ro, in vec3 rd, float time )
{
	vec4 rez = vec4(0);
	float t = 1.5;
	for(int i=0; i<60; i++) // Reduced iterations
	{
		vec3 pos = ro + t*rd;
        vec2 mpv = map(pos);
		float den = clamp(mpv.x-0.3,0.,1.);
        
		vec4 col = vec4(0);
        if (mpv.x > 0.6)
        {
            col = vec4(sin(vec3(5.,0.4,0.2) + mpv.y*0.1 + 1.8)*0.5 + 0.5, 0.08);
            col *= den*den*den;
        }
		
		rez = rez + col*(1. - rez.a);
		t += clamp(0.5 - den*den*.05, 0.09, 0.3);
	}
	return clamp(rez, 0.0, 1.0);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{	
	vec2 p = (fragCoord.xy - 0.5*iResolution.xy) / iResolution.y;
    
    float time = iTime*3.;
    vec3 ro = vec3(0,0,time);
    vec3 rd = normalize(p.x * vec3(1,0,0) + p.y * vec3(0,1,0) - vec3(0,0,1));
	vec4 scn = render(ro, rd, time);
		
    vec3 col = scn.rgb;
    col = pow(col, vec3(.55,0.65,0.6))*vec3(1.,.97,.9);
    col *= pow( 16.0*p.x*p.y*(1.0-p.x)*(1.0-p.y), 0.12)*0.7+0.3;
	
	fragColor = vec4(col, 1.0);
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
