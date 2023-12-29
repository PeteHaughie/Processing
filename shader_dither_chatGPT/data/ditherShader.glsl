#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D u_dither_tex;
uniform sampler2D u_color_tex;
uniform sampler2D tex0; // This is Processing's default texture

uniform int u_bit_depth;
uniform float u_contrast;
uniform float u_offset;
uniform int u_dither_size;

uniform vec2 u_color_tex_size;
uniform vec2 u_dither_tex_size;

varying vec2 vertTexCoord; // This is Processing's default texture coordinate variable

void main() 
{
    vec2 UV = vertTexCoord;
    UV.y = 1.0 - UV.y; // Flipping Y coordinate for Processing

    vec2 screen_size = vec2(textureSize(tex0, 0)) / float(u_dither_size);
    vec2 screen_sample_uv = floor(UV * screen_size) / screen_size;
    vec3 screen_col = texture2D(tex0, screen_sample_uv).rgb;
    
    float lum = (screen_col.r * 0.299) + (screen_col.g * 0.587) + (screen_col.b * 0.114);
    
    float contrast = u_contrast;
    lum = (lum - 0.5 + u_offset) * contrast + 0.5;
    lum = clamp(lum, 0.0, 1.0);
    
    float bits = float(u_bit_depth);
    lum = floor(lum * bits) / bits;
    
    vec2 col_size = u_color_tex_size / u_color_tex_size.y;
    
    float col_x = float(col_size.x) - 1.0; 
    float col_texel_size = 1.0 / col_x;
    
    lum = max(lum - 0.00001, 0.0);
    float lum_lower = floor(lum * col_x) * col_texel_size;
    float lum_upper = (floor(lum * col_x) + 1.0) * col_texel_size;
    float lum_scaled = lum * col_x - floor(lum * col_x);
    
    vec2 inv_noise_size = vec2(1.0 / u_dither_tex_size.x, 1.0 / u_dither_tex_size.y);
    vec2 noise_uv = UV * inv_noise_size * vec2(float(screen_size.x), float(screen_size.y));
    float threshold = texture2D(u_dither_tex, noise_uv).r;
    
    threshold = threshold * 0.99 + 0.005;
    
    float ramp_val = lum_scaled < threshold ? 0.0f : 1.0f;
    float col_sample = mix(lum_lower, lum_upper, ramp_val);
    vec3 final_col = texture2D(u_color_tex, vec2(col_sample, 0.5)).rgb;
    
    gl_FragColor = vec4(final_col, 1.0); // Set the alpha to 1.0
}
