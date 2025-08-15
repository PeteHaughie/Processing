#version 410

// #ifdef GL_ES
// precision mediump float;
// #endif

const float blurSize = 1.0/512.0;
const float intensity = 0.35;
uniform vec2 resolution;
uniform float iTime;
uniform sampler2D u_texture;

out vec4 fragColor;

void main()
{
    vec2 fragCoord = gl_FragCoord.xy;
    vec4 sum = vec4(0);
    vec2 uv = fragCoord.xy/resolution.xy;
    int j;
    int i;

    //thank you! http://www.gamerendering.com/2008/10/11/gaussian-blur-filter-shader/ for the 
    //blur tutorial
    // blur in y (vertical)
    // take nine samples, with the distance blurSize between them
    sum += texture(u_texture, vec2(uv.x - 4.0 * blurSize, uv.y)) * 0.05;
    sum += texture(u_texture, vec2(uv.x - 3.0 * blurSize, uv.y)) * 0.09;
    sum += texture(u_texture, vec2(uv.x - 2.0 * blurSize, uv.y)) * 0.12;
    sum += texture(u_texture, vec2(uv.x - blurSize, uv.y)) * 0.15;
    sum += texture(u_texture, vec2(uv.x, uv.y)) * 0.16;
    sum += texture(u_texture, vec2(uv.x + blurSize, uv.y)) * 0.15;
    sum += texture(u_texture, vec2(uv.x + 2.0 * blurSize, uv.y)) * 0.12;
    sum += texture(u_texture, vec2(uv.x + 3.0 * blurSize, uv.y)) * 0.09;
    sum += texture(u_texture, vec2(uv.x + 4.0 * blurSize, uv.y)) * 0.05;

    // blur in y (vertical)
    // take nine samples, with the distance blurSize between them
    sum += texture(u_texture, vec2(uv.x, uv.y - 4.0 * blurSize)) * 0.05;
    sum += texture(u_texture, vec2(uv.x, uv.y - 3.0 * blurSize)) * 0.09;
    sum += texture(u_texture, vec2(uv.x, uv.y - 2.0 * blurSize)) * 0.12;
    sum += texture(u_texture, vec2(uv.x, uv.y - blurSize)) * 0.15;
    sum += texture(u_texture, vec2(uv.x, uv.y)) * 0.16;
    sum += texture(u_texture, vec2(uv.x, uv.y + blurSize)) * 0.15;
    sum += texture(u_texture, vec2(uv.x, uv.y + 2.0 * blurSize)) * 0.12;
    sum += texture(u_texture, vec2(uv.x, uv.y + 3.0 * blurSize)) * 0.09;
    sum += texture(u_texture, vec2(uv.x, uv.y + 4.0 * blurSize)) * 0.05;

    //increase blur with intensity!
    //fragColor = sum*intensity + texture(texture, uv);

    if(sin(iTime) > 0.0)
        fragColor = sum * sin(iTime)+ texture(u_texture, uv);
    else
        fragColor = sum * -sin(iTime)+ texture(u_texture, uv);
}
