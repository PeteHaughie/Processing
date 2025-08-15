#version 410

uniform vec3 iResolution;
uniform float iTime;

out vec4 outColor;

void mainImage(out vec4 fragColor, in vec2 fragCoord);

void main() {
    outColor = vec4(0.0, 0.0, 0.0, 0.0);
    vec4 color = vec4(100000002004087734272.0, 100000002004087734272.0, 100000002004087734272.0, 100000002004087734272.0);
    mainImage(color, gl_FragCoord.xy);
    outColor = color;
}

float hash12(in vec2 p) {
    vec3 p3 = fract(vec3(p.x, p.y, p.x) * 0.1031);
    p3 += dot(p3, p3.yzx + 9.0);
    return fract((p3.x + p3.y) * p3.z);
}

float noise(in vec2 x) {
    vec2 f = fract(x);
    f = f * f * (3.0 - 2.0 * f);
    return mix(mix(hash12(floor(x)), hash12(floor(x) + vec2(1.0, 0.0)), f.x),
               mix(hash12(floor(x) + vec2(0.0, 1.0)), hash12(floor(x) + vec2(1.0, 1.0)), f.y),
               f.y);
}

vec4 circle(in vec2 uv, in vec2 pos, in float sz) {
    float s = (3.0 + 0.0 * pow(noise(vec2(iTime * 0.5)), 2.0)) / sz;
    uv += pos + vec2(1.0 / s);
    float val = clamp(1.0 - length(s * uv - 1.0), 0.0, 1.0);
    val = pow(5.0 * val, 1.0);
    return vec4(clamp(val, 0.0, 1.0));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    fragColor = vec4(0.0, 0.0, 0.0, 0.0);
    vec2 uv = fragCoord.xy / iResolution.yy;
    fragColor = circle(uv, vec2(-0.888888, -0.34999999), 1.0) - circle(uv, vec2(-0.888888, -0.34999999), 0.88);
}
