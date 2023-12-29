#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D buffer; // The texture input from previous frame
varying vec2 vTexCoord;   // Texture coordinate from the vertex shader

void main() {
    // Slightly shift texture coordinates
    vec2 coord = vTexCoord + vec2(0.01, 0.01);

    // Wrap around the edges
    coord = fract(coord);

    // Sample the texture
    vec4 color = texture2D(buffer, coord);

    // Output the color
    gl_FragColor = color;
}
