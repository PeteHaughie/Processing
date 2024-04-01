#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;
uniform sampler2D texture;

void main() {
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    // Invert the image by subtracting the UV coordinates from 1
    uv = 1.0 - uv;
    
    // Add wavy effects to both the x and y coordinates
    float waveX = sin(uv.y * 10.0 + time * 0.7) * 0.01;
    float waveY = sin(uv.x * 10.0 + time * 0.7) * 0.01;
    vec2 wavyUv = vec2(uv.x + waveX, uv.y + waveY);
    
    gl_FragColor = texture2D(texture, wavyUv);
}
