precision mediump float;
varying vec2 tcoord;// location
uniform sampler2D tex;// texture one
uniform sampler2D tex2;// texture two
uniform vec2 tres;// size of texture (screen)
uniform vec4 fparams;// 4 floats coming in
uniform ivec4 iparams;// 4 ints coming in
uniform float ftime;// 0.0 to 1.0
uniform int itime;// increases when ftime hits 1.0
//f0:horz stretch:
//f1:vert stretch:
//f2:color changes:
float f0=mix(.05,.95,fparams[0]);
float f1=mix(.05,.95,fparams[1]);
float f2=mix(.05,.95,fparams[2]);

float time=float(itime)+ftime;
vec2 resolution=tres;

void main(void){

    vec2 position=(gl_FragCoord.xy/resolution.xy)*vec2(f0,f1)*8.;
    float depth=gl_FragCoord.z;

    float color=.5;

    float my_mod=5.;

    color*=abs(mod(position.x*my_mod*sin(position.x)*position.y+cos(time),position.x*my_mod*cos(position.x)*position.x+sin(time)));
    color*=abs(mod(position.y*my_mod*cos(position.y)*position.x+sin(time),position.y*my_mod*sin(position.y)*position.y+cos(time)));

    gl_FragColor=vec4(color*.2/f2,color*.1+f2,color,1.);
}