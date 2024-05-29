#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform sampler2D u_tex0;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = vec2(fragCoord.x, u_resolution.y - fragCoord.y) / u_resolution; // Normalize pixel coordinates with reversed y-axis
    vec4 color = texture2D(u_tex0, uv);
    fragColor = vec4(color);
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy); // Call mainImage function
}
