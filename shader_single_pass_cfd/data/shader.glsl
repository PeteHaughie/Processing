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

uniform int iFrame;
uniform vec2 iResolution;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;

#define RotNum 3
#define angRnd 1.
#define posRnd 0.

// #define Res iChannelResolution[0]
// #define Res1 iChannelResolution[1]
vec2 Res = iResolution;
vec2 Res1 = Res;

const float ang=2.*3.1415926535/float(RotNum);
mat2 m=mat2(cos(ang),sin(ang),-sin(ang),cos(ang));

float hash(float seed){return fract(sin(seed)*158.5453);}
vec4 getRand4(float seed){return vec4(hash(seed),hash(seed+123.21),hash(seed+234.32),hash(seed+453.54));}
vec2 uv;
vec4 randS(vec2 uv)
{
    //return getRand4(uv.y+uv.x*1234.567)-vec4(0.5);
    return texture2D(iChannel1,uv*Res.xy/Res1.xy)-vec4(.5);
}

float rot;
float sc;
vec2 p2;

float getRot(vec2 uv,float sc)
{
    float ang2=angRnd*randS(uv).x*ang;
    vec2 p=vec2(cos(ang2),sin(ang2));
    rot=0.;
    for(int i=0;i<RotNum;i++)
    {
        p2=(p+posRnd*randS(uv+p*sc).xy)*sc;
        vec2 v=texture2D(iChannel0,fract(uv+p2)).xy-vec2(.5);
        rot+=cross(vec3(v,0.),vec3(p2,0.)).z/dot(p2,p2);
        p=m*p;
    }
    rot/=float(RotNum);
    return rot;
}

void init(out vec4 fragColor,in vec2 fragCoord)
{
vec2 uv=fragCoord.xy/Res.xy;
    fragColor=texture2D(iChannel2,uv);
}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=fragCoord.xy/Res.xy;
    vec2 scr=uv*2.-vec2(1.);

    sc=1./max(Res.x,Res.y);
    vec2 v=vec2(0);
    for(int level=0;level<20;level++)
    {
        if(sc>.7)break;
        float ang2=angRnd*ang*randS(uv).y;
        vec2 p=vec2(cos(ang2),sin(ang2));
        for(int i=0;i<RotNum;i++)
        {
            p2=p*sc;
            rot=getRot(uv+p2,sc);
            //v+=cross(vec3(0,0,rot),vec3(p2,0.0)).xy;
            v+=p2.yx*rot*vec2(-1,1);//maybe faster than above
            p=m*p;
        }
        sc*=2.;
    }

    //v.y+=scr.y*0.1;

    //v.x+=(1.0-scr.y*scr.y)*0.8;

    //v/=float(RotNum)/3.0;

    fragColor=texture2D(iChannel0,fract(uv+v*3./Res.x));

    // add a little "motor" in the center
    fragColor.xy+=(.01*scr.xy/(dot(scr,scr)/.1+.3));
    if(iFrame<=4)init(fragColor,fragCoord);
}

void main(){
    mainImage(gl_FragColor,gl_FragCoord.xy);
}
