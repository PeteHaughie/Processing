#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D u_tex;
uniform vec2 u_resolution;
uniform float u_threshold;
uniform vec3 u_color;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = vec2(fragCoord.x, fragCoord.y) / u_resolution.xy; // Normalize pixel coordinates with reversed y-axis
    vec4 color = texture2D(u_tex, uv.xy);
    float difference = length(u_color - color.rgb);
    if(difference < u_threshold){
        discard;
    } else {
        fragColor = vec4(color);
    }
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy); // Call mainImage function
}
