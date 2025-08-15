// GLSL Fragment Shader for Plane Rendering
uniform sampler2D sTD_texture;  // Optionally texture the plane

// in vec2 uv;  // The UV coordinates interpolated from the vertex shader
out vec4 fragColor;

void main() {
    // Sample the texture color and output it
    vec4 color = texture(sTD_texture, gl_FragCoord.xy);
    fragColor = TDOutputSwizzle(color);  // You can also use vec4(1.0) for white, etc.
}
