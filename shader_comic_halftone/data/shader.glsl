#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 iResolution;
uniform sampler2D iChannel0;

float HueToRGB(float f1, float f2, float hue)
{
	if (hue < 0.0)
		hue += 1.0;
	else if (hue > 1.0)
		hue -= 1.0;
	float res;
	if ((6.0 * hue) < 1.0)
		res = f1 + (f2 - f1) * 6.0 * hue;
	else if ((2.0 * hue) < 1.0)
		res = f2;
	else if ((3.0 * hue) < 2.0)
		res = f1 + (f2 - f1) * ((2.0 / 3.0) - hue) * 6.0;
	else
		res = f1;
	return res;
}

vec3 RGBToHSL(vec3 color)
{
	vec3 hsl; // init to 0 to avoid warnings ? (and reverse if + remove first part)
	
	float fmin = min(min(color.r, color.g), color.b);    //Min. value of RGB
	float fmax = max(max(color.r, color.g), color.b);    //Max. value of RGB
	float delta = fmax - fmin;             //Delta RGB value

	hsl.z = (fmax + fmin) / 2.0; // Luminance

	if (delta == 0.0)		//This is a gray, no chroma...
	{
		hsl.x = 0.0;	// Hue
		hsl.y = 0.0;	// Saturation
	}
	else                                    //Chromatic data...
	{
		if (hsl.z < 0.5)
			hsl.y = delta / (fmax + fmin); // Saturation
		else
			hsl.y = delta / (2.0 - fmax - fmin); // Saturation
		
		float deltaR = (((fmax - color.r) / 6.0) + (delta / 2.0)) / delta;
		float deltaG = (((fmax - color.g) / 6.0) + (delta / 2.0)) / delta;
		float deltaB = (((fmax - color.b) / 6.0) + (delta / 2.0)) / delta;

		if (color.r == fmax )
			hsl.x = deltaB - deltaG; // Hue
		else if (color.g == fmax)
			hsl.x = (1.0 / 3.0) + deltaR - deltaB; // Hue
		else if (color.b == fmax)
			hsl.x = (2.0 / 3.0) + deltaG - deltaR; // Hue

		if (hsl.x < 0.0)
			hsl.x += 1.0; // Hue
		else if (hsl.x > 1.0)
			hsl.x -= 1.0; // Hue
	}

	return hsl;
}

vec3 HSLToRGB(vec3 hsl)
{
	vec3 rgb;
	
	if (hsl.y == 0.0)
		rgb = vec3(hsl.z, hsl.z, hsl.z); // Luminance
	else
	{
		float f2;
		
		if (hsl.z < 0.5)
			f2 = hsl.z * (1.0 + hsl.y);
		else
			f2 = (hsl.z + hsl.y) - (hsl.y * hsl.z);
			
		float f1 = 2.0 * hsl.z - f2;
		
		rgb.r = HueToRGB(f1, f2, hsl.x + (1.0/3.0));
		rgb.g = HueToRGB(f1, f2, hsl.x);
		rgb.b= HueToRGB(f1, f2, hsl.x - (1.0/3.0));
	}
	
	return rgb;
}

float _sind( in float _a) {
  {
    return sin((_a * 0.017453292));;
  }
}

float _cosd( in float _a) {
  {
    return cos((_a * 0.017453292));;
  }
}

float _added( in vec2 _sh, in float _sa, in float _ca, in vec2 _c, in float _d) {
  {
    return ((0.5 + (0.25 * cos(((((_sh.x * _sa) + (_sh.y * _ca)) + _c.x) * _d)))) + (0.25 * cos(((((_sh.x * _ca) - (_sh.y * _sa)) + _c.y) * _d))));;
  }
}

vec4 Halftone(in vec2 _fragCoord) {
  {
    float _threshold = 0.8;
    float _ratio = (iResolution.y / iResolution.x);
    float _coordX = (_fragCoord.x / iResolution.x);
    float _coordY = (_fragCoord.y / iResolution.x);
    vec2 _dstCoord = vec2(_coordX, _coordY);
    vec2 _srcCoord = vec2(_coordX, (_coordY / _ratio));
    vec2 _rotationCenter = vec2(0.5, 0.5);
    vec2 _shift = (_dstCoord - _rotationCenter);
    float _dotSize = 3.0;
    float _angle = 45.0;
    float _rasterPattern = _added(_shift, _sind(_angle), _cosd(_angle), _rotationCenter, ((3.1415927 / _dotSize) * 680.0));
    vec4 _srcPixel = texture2D(iChannel0, _srcCoord);
    float _avg = (((0.21250001 * _srcPixel.x) + (0.71539998 * _srcPixel.y)) + (0.072099999 * _srcPixel.z));
    float _gray = ((((_rasterPattern * _threshold) + _avg) - _threshold) / (1.0 - _threshold));
    return vec4(_gray, _gray, _gray, 1.0) * _srcPixel;
  }
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
    
    float fCartoonEffect = 50.0;
    float outline = 0.0002;
    float saturation = 2.0;
    
    float SensitivityUpper = fCartoonEffect;
	float SensitivityLower = fCartoonEffect;
    
	float dx = iResolution.x/iResolution.y * outline;
	float dy = outline;   
    
	vec4 c1 = texture(iChannel0, uv +  vec2(-dx,-dy));
	vec4 c2 = texture(iChannel0, uv + vec2(0,-dy));
	vec4 c3 = texture(iChannel0, uv +  vec2(-dx,dy));
	vec4 c4 = texture(iChannel0, uv +  vec2(-dx,0));
	vec4 c5 = texture(iChannel0, uv +  vec2(0,0));
	vec4 c6 = texture(iChannel0, uv +  vec2(dx,0));
	vec4 c7 = texture(iChannel0, uv +  vec2(dx,-dy));
	vec4 c8 = texture(iChannel0, uv +  vec2(0,dy));
	vec4 c9 = texture(iChannel0, uv +  vec2(dx,dy));    
    
	vec4 c0 = (-c1-c2-c3-c4+c6+c7+c8+c9);

    vec4 average = (c1 + c2 + c3 + c4 + c6 +  c7 + c8 + c9) - (c5 * 6.0);
	float av = (average.x + average.y + average.z) / 3.0;   
    
	c0 = vec4(1.0-abs((c0.r+c0.g+c0.b)/av));
    float val = pow(clamp((c0.r + c0.g + c0.b) / 3.0,0.0,1.0), SensitivityUpper);
	val = 1.0 - pow(abs(1.0 - val), SensitivityLower);
    c0 = vec4(val, val, val, val);    
    
    c1 = texture(iChannel0, uv);
    
	vec3 hsl = RGBToHSL(c1.xyz);
	hsl.g *= saturation;
	c1 = vec4(HSLToRGB(hsl),1.0);

	vec4 basePixel = c1 * c0;
    vec4 overlayPixel = Halftone(fragCoord);
    
    if (overlayPixel.x > 0.0) {
      overlayPixel = basePixel;
	}
    
    fragColor = overlayPixel;
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
