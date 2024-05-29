#ifdef GL_ES
precision mediump float;
#endif

// Uniform variables
uniform vec2 u_resolution; // Resolution of the screen
uniform sampler2D u_tex0; // Texture sampler
uniform float u_x0; // Parameter for colorization
uniform float u_x1; // Parameter for colorization
uniform float u_x2; // Parameter for colorization

// Function to convert RGB color to grayscale
vec3 rgb2grayscale(vec3 c) {
    return vec3(dot(c, vec3(0.299, 0.587, 0.114)));
}

// Function to convert RGB color to HSV color
vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

// Function to convert HSV color to RGB color
vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

// Main function to process each pixel
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = vec2(fragCoord.x, fragCoord.y) / u_resolution.xy; // Normalize pixel coordinates with reversed y-axis
    vec4 color = texture2D(u_tex0, uv.xy); // Get color from texture

    vec3 gray = rgb2grayscale(color.rgb); // Convert color to grayscale
    vec3 hsv = rgb2hsv(color.rgb); // Convert color to HSV

    const int intDiv = 20; // Number of divisions for colorization
    float divisions = float(intDiv);
    float lum = (gray.x + gray.y + gray.z) / (3.0 * u_x2); // Calculate luminance

    vec3 newColor = vec3(0.0, 0.7, 0.7); // Default color
    for (int i = 0; i < intDiv; i++) {
        if (lum >= float(i) / divisions && lum < (float(i) + 1.0 * u_x1) / divisions * u_x2) {
            newColor.x = mod((float(i) / divisions * u_x0) / u_x1 + u_x2, 1.0 * u_x0); // Calculate new color value
        }
    }

    // Main colorizer
    fragColor = vec4(hsv2rgb(newColor * u_x1) / u_x2, color.a + (hsv.z / u_x0)); // Set final color
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy); // Call mainImage function
}
