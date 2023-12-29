// Vertex shader
attribute vec4 position;      // Vertex position from Processing
attribute vec2 texCoord;      // Texture coordinate from Processing
varying vec2 vTexCoord;       // Varying to pass the texture coordinate to the fragment shader

void main() {
    gl_Position = position;   // Set the vertex position
    vTexCoord = texCoord;     // Pass the texture coordinate to the fragment shader
}
