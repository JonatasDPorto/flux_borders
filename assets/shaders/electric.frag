#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;      // 0
uniform float uTime;     // 1
uniform float uRadius;   // 2
uniform float uWidth;    // 3
uniform vec3 uColor1;    // 4
uniform vec3 uColor2;    // 5
uniform float uParam1;   // 6
uniform float uParam2;   // 7
uniform float uGlow;     // 8
uniform float uExtraPad; // 9

out vec4 fragColor;

float sdRoundedBox(vec2 p, vec2 b, float r) {
    vec2 q = abs(p) - b + vec2(r);
    return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - r;
}

void main() {
    vec2 pos = FlutterFragCoord().xy;
    vec2 center = pos - uSize * 0.5;
    
    vec2 boxSize = (uSize * 0.5) - vec2(uExtraPad) - vec2(uWidth * 0.5);
    
    float minDim = min(boxSize.x, boxSize.y);
    float safeRadius = min(uRadius, minDim);

    float d = sdRoundedBox(center, boxSize, safeRadius);

    float halfWidth = uWidth * 0.5;
    float coreThickness = halfWidth * 0.5; 

    float dist = abs(d);
    float coreMask = 1.0 - smoothstep(coreThickness - 0.5, coreThickness + 0.5, dist);

    float angle = atan(center.y, center.x);
    float noise = sin(angle * 20.0 + uTime * 10.0) * sin(angle * 43.0 - uTime * 15.0);
    float energy = smoothstep(0.2, 1.0, noise);
    float pulse = (sin(uTime * 5.0) * 0.5 + 0.5);
    float animIntensity = energy * 0.8 + pulse * 0.2;

    vec3 activeColor = uColor1;
    if (uGlow > 0.0) {
        activeColor *= (1.0 + uGlow * 2.5);
        if (uGlow > 0.5) activeColor = mix(activeColor, vec3(1.0), (uGlow - 0.5) * 0.5);
    }
    
    float glowFactor = 0.0;
    if (uGlow > 0.0) {
        float falloff = 0.05 / (uGlow * 0.5 + 0.5);
        glowFactor = exp(-falloff * dist * dist) * uGlow * 2.0 * animIntensity;
    }

    vec3 finalColor = vec3(0.0);
    float finalAlpha = 0.0;

    finalColor += uColor2 * coreMask;
    finalAlpha = max(finalAlpha, coreMask);

    vec3 visibleCore = mix(uColor2, activeColor, animIntensity);
    finalColor = mix(finalColor, visibleCore, coreMask);
    finalAlpha = max(finalAlpha, coreMask);

    vec3 renderedGlow = activeColor * glowFactor;
    float glowAlpha = clamp(glowFactor, 0.0, 1.0);
    
    finalColor = max(finalColor, renderedGlow);
    finalAlpha = max(finalAlpha, max(coreMask, glowAlpha * 0.5));
    
    fragColor = vec4(finalColor, finalAlpha);
}
