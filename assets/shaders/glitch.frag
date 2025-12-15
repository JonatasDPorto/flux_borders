#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;      // 0
uniform float uTime;     // 1
uniform float uRadius;   // 2
uniform float uWidth;    // 3
uniform vec3 uColor1;    // 4
uniform vec3 uColor2;    // 5
uniform float uParam1;   // 6 - Glitch Intensity
uniform float uParam2;   // 7 - Segment Size
uniform float uGlow;     // 8
uniform float uExtraPad; // 9

out vec4 fragColor;

float sdRoundedBox(vec2 p, vec2 b, float r) {
    vec2 q = abs(p) - b + vec2(r);
    return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - r;
}

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

void main() {
    vec2 pos = FlutterFragCoord().xy;
    vec2 center = pos - uSize * 0.5;
    vec2 boxSize = (uSize * 0.5) - vec2(uExtraPad) - vec2(uWidth * 0.5);
    float safeRadius = min(uRadius, min(boxSize.x, boxSize.y));

    float d = sdRoundedBox(center, boxSize, safeRadius);
    float dist = abs(d);

    // --- GLITCH LOGIC ---
    // We distort the distance and opacity based on time and position
    float segmentSize = uParam2 > 0.0 ? uParam2 * 50.0 : 50.0;
    float intensity = uParam1 > 0.0 ? uParam1 : 1.0;
    
    // Snap position to grid for blocky look
    float block = floor(pos.x / segmentSize) + floor(pos.y / segmentSize);
    float noise = random(vec2(block, floor(uTime * 15.0))); // Fast flicker
    
    // Shift flicker
    float shift = 0.0;
    if (noise > 0.8 / intensity) {
        shift = (noise - 0.5) * 10.0 * intensity;
    }
    
    float dGlitch = abs(d + shift);
    float halfWidth = uWidth * 0.5;
    
    // Core Mask
    float coreMask = 1.0 - smoothstep(halfWidth - 1.0, halfWidth, dGlitch);
    
    // Glitchy Holes
    if (noise < 0.2 * intensity) coreMask = 0.0;

    // Color Split (Chromatic Aberration simulated)
    vec3 activeColor = uColor1;
    if (noise > 0.9) activeColor = vec3(1.0); // Flash white
    
    // Glow
    float glowFactor = 0.0;
    if (uGlow > 0.0) {
        float falloff = 0.05 / (uGlow * 0.5 + 0.5);
        glowFactor = exp(-falloff * dGlitch * dGlitch) * uGlow * 2.0;
        // Glitch the glow too
        if (noise < 0.3) glowFactor *= 0.2; 
    }

    vec3 finalColor = vec3(0.0);
    float finalAlpha = 0.0;

    // Background
    float bgMask = 1.0 - smoothstep(halfWidth - 0.5, halfWidth + 0.5, dist);
    finalColor += uColor2 * bgMask;
    finalAlpha = max(finalAlpha, bgMask);

    // Core
    finalColor = mix(finalColor, activeColor, coreMask);
    finalAlpha = max(finalAlpha, coreMask);

    // Glow
    vec3 renderedGlow = activeColor * glowFactor;
    float glowAlpha = clamp(glowFactor, 0.0, 1.0);
    
    finalColor = max(finalColor, renderedGlow);
    finalAlpha = max(finalAlpha, max(coreMask, glowAlpha * 0.5));

    fragColor = vec4(finalColor, finalAlpha);
}

