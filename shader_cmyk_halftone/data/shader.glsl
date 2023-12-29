#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 iResolution;
uniform sampler2D iChannel0;

const float PI = 3.1415926535897932384626433832795;
const float PI180 = float(PI / 180.0);

float sind(float a)
{
	return sin(a * PI180);
}

float cosd(float a)
{
	return cos(a * PI180);
}

float added(vec2 sh, float sa, float ca, vec2 c, float d)
{
	return 0.5 + 0.25 * cos((sh.x * sa + sh.y * ca + c.x) * d) + 0.25 * cos((sh.x * ca - sh.y * sa + c.y) * d);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// Halftone dot matrix shader
	// @author Tomek Augustyn 2010
	
	// Ported from my old PixelBender experiment
	// https://github.com/og2t/HiSlope/blob/master/src/hislope/pbk/fx/halftone/Halftone.pbk
	
	// Hold and drag horizontally to adjust the threshold

	float threshold = 0.75;

	float ratio = iResolution.y / iResolution.x;
	float coordX = fragCoord.x / iResolution.x;
	float coordY = fragCoord.y / iResolution.x;
	vec2 dstCoord = vec2(coordX, coordY);
	vec2 srcCoord = vec2(coordX, coordY / ratio);
	vec2 rotationCenter = vec2(0.5, 0.5);
	vec2 shift = dstCoord - rotationCenter;

    float dotSize = 6.0;//clamp(float(iMouse.x / iResolution.x) + 2.6, 3.0, 10.0);
	float angle = 30.0;
    
    vec3 rasterPattern = vec3(
        added(shift, sind(angle + 00.0), cosd(angle), rotationCenter, PI / dotSize * 680.0),
        added(shift, sind(angle + 30.0), cosd(angle), rotationCenter, PI / dotSize * 680.0),
        added(shift, sind(angle + 60.0), cosd(angle), rotationCenter, PI / dotSize * 680.0)
    );
	
	vec4 srcPixel = texture2D(iChannel0, srcCoord);
       
	fragColor = vec4(
        (rasterPattern.r * threshold + srcPixel.r - threshold) / (1.0 - threshold),
        (rasterPattern.g * threshold + srcPixel.g - threshold) / (1.0 - threshold),
        (rasterPattern.b * threshold + srcPixel.b - threshold) / (1.0 - threshold),
        1.0
   	);
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
