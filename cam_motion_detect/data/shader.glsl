#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 uResolution;
uniform sampler2D uBuffer;
uniform sampler2D uOrigin;

vec3 lowerBound = vec3(0.0, 0.0, 0.0);
vec3 upperBound = vec3(0.2, 0.2, 0.2);

// Function to check if a color is within the specified range
bool isColorInRange(vec3 color, vec3 lowerBound, vec3 upperBound) {
    return all(greaterThanEqual(color, lowerBound)) && all(lessThanEqual(color, upperBound));
}

void main() {
    vec2 texCoords   = gl_FragCoord.xy / uResolution;
    vec4 texColor    = texture2D(uBuffer, texCoords);
    vec4 originColor = texture2D(uOrigin, texCoords);
    if (isColorInRange(texColor.rgb, lowerBound, upperBound)) {
        // Return the non-black color
        // gl_FragColor = vec4(1.0, 0.0, 0.0, 0.0); // paint a black pixel with 0 alpha to screen
        gl_FragColor = originColor;
        // gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
    } else {
        // replace with white
        vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
        gl_FragColor = white;
        // gl_FragColor = mix(white, originColor, 0.5);
        // gl_FragColor = originColor;
    }
    // gl_FragColor = vec4(texColor.rgb, 1.0);    // DEBUG: write the RGB of the pixel with a variable alpha
    // gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0); // DEBUG: write a red field directly to the shader
    // gl_FragColor = texColor;                   // DEBUG: write the texture directly to the shader
}
