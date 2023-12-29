#ifdef GL_ES
precision mediump float;
#endif

#define RotNum 3
#define angRnd 1.0
#define posRnd 0.0

#define Res  iChannelResolution[0]
#define Res1 iChannelResolution[1]

uniform vec2 iChannelResolution[2];

uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;

uniform bool doInit = true;

const float ang = 2.0*3.1415926535/float(RotNum);
mat2 m = mat2(cos(ang),sin(ang),-sin(ang),cos(ang));

float hash(float seed) {
    return fract(sin(seed)*158.5453 );
}

vec4 getRand4(float seed) {
    return vec4(hash(seed),hash(seed+123.21),hash(seed+234.32),hash(seed+453.54));
}

vec4 randS(vec2 uv) {
    return texture2D(iChannel1,uv*Res.xy/Res1.xy)-vec4(0.5);
}

float getRot(vec2 uv, float sc) {
    float ang2 = angRnd*randS(uv).x*ang;
    vec2 p = vec2(cos(ang2),sin(ang2));
    float rot=0.0;
    for(int i=0;i<RotNum;i++) {
        vec2 p2 = (p+posRnd*randS(uv+p*sc).xy)*sc;
        vec2 v = texture2D(iChannel0,fract(uv+p2)).xy-vec2(0.5);
        rot+=cross(vec3(v,0.0),vec3(p2,0.0)).z/dot(p2,p2);
        p = m*p;
    }
    rot/=float(RotNum);
    return rot;
}

void init( out vec4 fragColor, in vec2 fragCoord ) {
	vec2 uv = fragCoord.xy / Res.xy;
    fragColor = texture2D(iChannel2,uv);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    if (doInit)
        init(gl_FragColor, gl_FragCoord.xy);
    vec2 uv = fragCoord.xy / Res.xy;
    vec2 scr=uv*2.0-vec2(1.0);
    
    float sc=1.0/max(Res.x,Res.y);
    vec2 v=vec2(0);
    for(int level=0;level<20;level++) {
        if ( sc > 0.7 ) break;
        float ang2 = angRnd*ang*randS(uv).y;
        vec2 p = vec2(cos(ang2),sin(ang2));
        for(int i=0;i<RotNum;i++)
        {
            vec2 p2=p*sc;
            float rot=getRot(uv+p2,sc);
            v+=p2.yx*rot*vec2(-1,1);
            p = m*p;
        }
      	sc*=2.0;
    }
    
    fragColor=texture2D(iChannel0,fract(uv+v*3.0/Res.x));
    
    // add a little "motor" in the center
    fragColor.xy += (0.01*scr.xy / (dot(scr,scr)/0.1+0.3));
    
}

void main() {
    
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
