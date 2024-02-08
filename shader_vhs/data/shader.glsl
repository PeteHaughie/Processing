#define SEQUENCE_LENGTH 24.
#define FPS 12.

uniform sampler2D iChannel0; // noise
uniform sampler2D iChannel1; // image
uniform vec2 iResolution;
uniform int iTime;

vec4 vignette(vec2 uv,float time)
{
    uv *= 1.-uv.yx;
    float vig = uv.x*uv.y*15.;
    float t = sin(time*23.)*cos(time*8.+.5);
    vig = pow(vig,.4+t*.05);
    return vec4(vig);
}

float easeIn(float t0,float t1,float t)
{
    return 2.*smoothstep(t0,2.*t1-t0,t);
}

vec4 blackAndWhite(vec4 color)
{
    return vec4(dot(color.xyz,vec3(.299,.587,.114)));
}

float filmDirt(vec2 pp,float time)
{
    float aaRad = .1;
    vec2 nseLookup2 = pp+vec2(.5,.9)+time*100.;
    vec3 nse2 =
        textureLod(iChannel0,.1*nseLookup2.xy,0.).xyz+
        textureLod(iChannel0,.01*nseLookup2.xy,0.).xyz+
        textureLod(iChannel0,.004*nseLookup2.xy+.4,0.).xyz;
    float thresh = .6;
    float mul1 = smoothstep(thresh-aaRad,thresh+aaRad,nse2.x);
    float mul2 = smoothstep(thresh-aaRad,thresh+aaRad,nse2.y);
    float mul3 = smoothstep(thresh-aaRad,thresh+aaRad,nse2.z);
    
    float seed = textureLod(iChannel0, vec2(time * .35, time), 0.).x;
    
    float result = clamp(0., 1., seed+.7) + .3 * smoothstep(0. ,SEQUENCE_LENGTH, time);

    result += .06 * easeIn(19.2, 19.4, time);
    
    float band = .05;

    if (.3 < seed && .3 + band > seed)
        return mul1 * result;
    if (.6 < seed && .6 + band > seed)
        return mul2 * result;
    if (.9 < seed &&.9 + band > seed)
        return mul3 * result;
    return result;
}

vec4 jumpCut(float seqTime)
{
    float toffset = 0.;
    vec3 camoffset = vec3(0.);
    
    float jct = seqTime;
	float jct1 = 7.7;
	float jct2 = 8.2;
    float jc1 = step(jct1,jct);
    float jc2 = step(jct2,jct);
    
    camoffset += vec3(.8,.0,.0)*jc1;
    camoffset += vec3(-.8,0.,.0)*jc2;
    
    toffset += .8*jc1;
    toffset -= (jc2-jc1)*(jct-jct1);
    toffset -= .9*jc2;
    
    return vec4(camoffset,toffset);
}

float limitFPS(float time,float fps)
{
    time = mod(time,SEQUENCE_LENGTH);
    return float(int(time*fps))/fps;
}

vec2 moveImage(vec2 uv,float time)
{
    uv.x += .002*(cos(time*3.)*sin(time*12.+.25));
    uv.y += .002*(sin(time*1.+.5)*cos(time*15.+.25));
    return uv;
}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv = fragCoord.xy/iResolution.xy;
    vec2 qq = -1.+2.*uv;
    qq.x *= iResolution.x/iResolution.y;
    
    float time = limitFPS(iTime,FPS);
    
    vec4 jumpCutData = jumpCut(time);
    vec4 dirt = vec4(filmDirt(qq,time+jumpCutData.w));
    vec4 image = texture(iChannel1,moveImage(uv,time));
    vec4 vig = vignette(uv,time);

    float seed = filmDirt(qq, time);

    // fragColor = image;
    // fragColor = image * vig;
    // fragColor = dirt;
    // fragColor = image * dirt;
    // fragColor = vig;
    fragColor = image * dirt * vig;
    fragColor = blackAndWhite(fragColor);
    /*
    if (seed < 0.3) {
        fragColor = vec4(1.0, 0.0, 0.0, 1.0);
    } else if (seed > 0.3 && seed < 0.6) {
        fragColor = vec4(0.0, 1.0, 0.0, 1.0);
    } else if (seed > 0.6) {
        fragColor = vec4(0.0, 0.0, 1.0, 1.0);
    } else {
        fragColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    */
}

void main(){
    mainImage(gl_FragColor,gl_FragCoord.xy);
}