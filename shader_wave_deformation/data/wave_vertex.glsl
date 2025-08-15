#version 410

uniform mat4 modelViewProjectionMatrix;
uniform float u_time;
uniform float u_amplitude;
uniform float u_frequency;

in vec4 position;
in vec2 texcoord;

out vec2 vTexCoord;

void main() {
    // Calculate wave deformation
    float wave = sin(position.x * u_frequency + u_time) * u_amplitude;
    
    // Adjust position by the wave value
    vec4 newPosition = position;
    newPosition.z += wave;

    // Transform the position with the model-view-projection matrix
    gl_Position = modelViewProjectionMatrix * newPosition;

    // Pass the texture coordinates to the fragment shader
    vTexCoord = texcoord;
}
