#ifdef GL_ES
precision mediump float;
#endif

#define Dither
#define DownScale 2.0
#define DistanceParam 0.25 // [0-1]

#define Mode_EGA 0
#define Mode_CGA 1
#define Mode_Monochrome 2
#define Mode_Grayscale4 3
#define Mode_CGA2 4

#define Mode Mode_CGA

#if (Mode == Mode_EGA)
#define PaletteSize 16

vec3 palette[PaletteSize];
uniform vec2 iResolution;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform vec2 iChannel0Resolution;

void init()
{
	palette = vec3[]
    (
        vec3(  0,   0,   0)/255.0,
        vec3(  0,   0, 170)/255.0,
        vec3(  0, 170,   0)/255.0,
        vec3(  0, 170, 170)/255.0,	
        vec3(170,   0,   0)/255.0,
        vec3(170,   0, 170)/255.0,
        vec3(170,  85,   0)/255.0,
        vec3(170, 170, 170)/255.0,	
        vec3( 85,  85,  85)/255.0,
        vec3( 85,  85, 255)/255.0,
        vec3( 85, 255,  85)/255.0,
        vec3( 85, 255, 255)/255.0,	
        vec3(255,  85,  85)/255.0,
        vec3(255,  85, 255)/255.0,
        vec3(255, 255,  85)/255.0,
        vec3(255, 255, 255)/255.0
	);
}
#endif

#if (Mode == Mode_CGA)
#define PaletteSize 4

vec3 palette[PaletteSize];

void init()
{
	palette = vec3[]
    (
        vec3(  0,   0,   0)/255.0,
        vec3(255,  85, 255)/255.0,
        vec3( 85, 255, 255)/255.0,
        vec3(255, 255, 255)/255.0
	);
}
#endif

#if (Mode == Mode_Monochrome)
#define PaletteSize 2

vec3 palette[PaletteSize];

void init()
{
	palette = vec3[]
    (
        vec3(  0,   0,   0)/255.0,
        vec3(255, 255, 255)/255.0
	);
}
#endif

#if (Mode == Mode_Grayscale4)
#define PaletteSize 4

vec3 palette[PaletteSize];

void init()
{
	palette = vec3[]
    (
        vec3(  0,   0,   0)/255.0,
        vec3( 85,  85,  85)/255.0,
        vec3(170, 170, 170)/255.0,
        vec3(255, 255, 255)/255.0
	);
}
#endif

#if (Mode == Mode_CGA2)
#define PaletteSize 4

vec3 palette[PaletteSize];

void init()
{
	palette = vec3[]
    (
        vec3(  0,   0,   0)/255.0,
        vec3(255,  85,  85)/255.0,
        vec3( 85, 255,  85)/255.0,
        vec3(255, 255,  85)/255.0
	);
}
#endif

float colorDistance(vec3 color, vec3 c1, vec3 c2, float frac)
{
    return mix(distance(color, mix(c1, c2, frac)), distance(color, c1) + distance(color, c2), 0.5*DistanceParam*DistanceParam);
}

vec3 getPalettifiedColor(vec3 color, vec2 coord)
{
    color *= color;

    vec3 c1 = vec3(0);
    vec3 c2 = vec3(0);
    
    float frac = 0.0;

    for (int i = 0; i < (PaletteSize - 1); ++i)
    {
        for (int j = i + 1; j < PaletteSize; ++j)
        {
            vec3 p1 = palette[i];
            vec3 p2 = palette[j];            
            
            p1 *= p1;
            p2 *= p2;
           
            vec3 num = p1*p1 - p1*color - p1*p2 + p2*color;
            vec3 den = p1*p1 - 2.0*p1*p2 + p2*p2;
            
            float a = (num.r + num.g + num.b)/(den.r + den.g + den.b);
            
            if (colorDistance(color, p1, p2, a) < colorDistance(color, c1, c2, frac))
            {
                c1 = p1;
                c2 = p2;
                frac = a;
            }
        }
    }
    
#ifdef Dither
    return sqrt(mix(c1, c2, float(frac > texture2D(iChannel0, coord/iChannelResolution.xy).r)));
#else
    return sqrt(mix(c1, c2, frac));
#endif
}


void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    init();
    
    fragCoord = floor(fragCoord/DownScale)*DownScale;
    
    vec2 uv = fragCoord.xy / iResolution.y;
  
    vec3 outColor = texture2D(iChannel1, fragCoord.xy/iResolution.xy).rgb;
    
    outColor = getPalettifiedColor(outColor, fragCoord.xy/DownScale);
    
    if (uv.x < 0.05)
    {
        float idx = clamp(uv.y, 0.0, 1.0)*float(PaletteSize);
        outColor = palette[int(idx)];
    }

    fragColor = vec4(outColor, 1.0);
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
