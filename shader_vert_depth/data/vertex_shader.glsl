// GLSL Vertex Shader for Plane Deformation
// 'u_displaceTex' is the grayscale texture from the webcam
uniform sampler2D u_displaceTex; 
uniform float u_displaceAmount;  // Control the amount of displacement
// in vec2 uv;  // UV coordinates from the Grid SOP
in vec3 P;   // Position of the current vertex

void main() {
    // Sample the grayscale texture based on the vertex UV
    float displacement = texture(u_displaceTex, uv).r;  // Assuming the texture is grayscale

    // Displace the vertex along the z-axis based on the grayscale value
    vec3 displacedPos = P + vec3(0.0, 0.0, displacement * u_displaceAmount);

    // Output the transformed position to the rest of the pipeline
    gl_Position = tdTransform(displacedPos);
}
