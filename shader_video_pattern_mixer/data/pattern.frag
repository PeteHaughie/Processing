#version 410

#ifdef GL_ES
precision mediump float;
#endif

out vec4 outputColor;

uniform vec2  u_resolution;
uniform float u_time;

#define hash(p) ( 2.* fract(sin( (p) * mat2(127.1,311.7,269.5,183.3))*43758.5453123) -1.)

/**
 * Calculates the color of a pixel in the perlinfall shader.
 *
 * @param O - Output color of the pixel.
 * @param u - Coordinates of the pixel in normalized screen space.
 */
void calculatePerlinfallColor(out vec4 outputColor, vec2 pixelCoords)
{
  // Get the resolution of the screen
  vec2 screenResolution = u_resolution.xy;

  // Normalize the pixel coordinates
  vec2 normalizedCoords = pixelCoords / screenResolution.y;

  // Calculate the V coordinate for the Perlin noise
  vec2 perlinCoords = 15.0 * normalizedCoords;
  perlinCoords.y += u_time;

  // Initialize the potential value
  float potential = 0.0;

  // Iterate over the neighborhood of the current pixel
  for (int k = 0; k < 9; k++)
  {
    // Calculate the current cell coordinates
    vec2 cellCoords = vec2(float(k % 3 - 1), float(k / 3 - 1));

    // Calculate the random offset in the cell
    vec2 cellOffset = fract(1e4 * sin(ceil(perlinCoords - cellCoords) * mat2(screenResolution.xyyx))) - 0.5;

    // Calculate the node relative coordinates
    vec2 nodeCoords = fract(perlinCoords) - 0.5 + cellCoords + cellOffset;

    // Calculate the potential of the node
    potential += smoothstep(1.3 * normalizedCoords.y, 0.0, length(nodeCoords));
  }

  // Set the output color based on the potential value
  vec3 color = vec3((potential - 0.5) / fwidth(potential));
  outputColor = vec4(color, 1.0);
}

void main() {
    calculatePerlinfallColor(outputColor, gl_FragCoord.xy);
}
