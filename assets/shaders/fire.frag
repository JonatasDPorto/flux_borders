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

// Simple noise
float hash(float n) { return fract(sin(n) * 43758.5453123); }
float noise(in vec2 x) {
    vec2 p = floor(x);
    vec2 f = fract(x);
    f = f*f*(3.0-2.0*f);
    float n = p.x + p.y*57.0;
    return mix(mix( hash(n+  0.0), hash(n+  1.0),f.x),
               mix( hash(n+ 57.0), hash(n+ 58.0),f.x),f.y);
}

void main() {
    vec2 pos = FlutterFragCoord().xy;
    vec2 center = pos - uSize * 0.5;
    vec2 boxSize = (uSize * 0.5) - vec2(uExtraPad) - vec2(uWidth * 0.5);
    float minDim = min(boxSize.x, boxSize.y);
    float safeRadius = min(uRadius, minDim);

    float d = sdRoundedBox(center, boxSize, safeRadius);
    
    // Fire logic
    // We distort the distance field 'd' outwards using noise
    
    float noiseScale = uParam1 > 0.0 ? uParam1 : 1.0;
    float timeScale = uParam2 > 0.0 ? uParam2 : 1.0;
    
    // Angle for radial noise coordinate
    float angle = atan(center.y, center.x);
    
    // FBM-ish
    float n = noise(vec2(angle * 10.0, d * 0.1 - uTime * 5.0 * timeScale));
    n += 0.5 * noise(vec2(angle * 20.0, d * 0.2 - uTime * 10.0 * timeScale));
    
    // Add noise to distance. Fire grows outwards (negative d)
    // We want the fire to be outside the box
    
    float fireDist = d + n * uWidth * 2.0 * noiseScale;
    
    // Core (Source of fire)
    float halfWidth = uWidth * 0.5;
    float coreMask = 1.0 - smoothstep(halfWidth - 1.0, halfWidth, abs(d)); // Solid base
    
    // Flames
    // Fire is where fireDist < threshold
    float flameMask = 1.0 - smoothstep(0.0, uWidth * 2.0, fireDist);
    // Clip inside
    flameMask *= step(d, halfWidth); 
    
    // Color gradient
    // uColor1 is the hot color (Yellow/White)
    // uColor2 is the cold color (Red/Orange) - Wait, standard uColor2 is bg.
    // Let's derive Red from uColor1 by darkening/hue shifting?
    // Or just use uColor1 as flame color fading to transparency.
    
    vec3 flameColor = uColor1;
    // Core is white hot
    if (d > -halfWidth && d < halfWidth) flameColor = mix(uColor1, vec3(1.0), 0.5);
    
    // Tips are darker/redder (simulated by dimming)
    flameColor *= (0.5 + 0.5 * flameMask);

    if (uGlow > 0.0) {
        flameColor *= (1.0 + uGlow * 3.0);
    }
    
    float glowFactor = 0.0;
    if (uGlow > 0.0) {
        float falloff = 0.05 / (uGlow * 0.5 + 0.5);
        glowFactor = exp(-falloff * abs(d) * abs(d)) * uGlow * 2.0 * flameMask;
    }

    vec3 finalColor = vec3(0.0);
    float finalAlpha = 0.0;

    // Background - Fire usually looks best on dark
    // Standard uColor2 usage:
    float bgMask = 1.0 - smoothstep(halfWidth - 0.5, halfWidth + 0.5, abs(d));
    finalColor += uColor2 * bgMask;
    finalAlpha = max(finalAlpha, bgMask);

    // Flame
    finalColor = mix(finalColor, flameColor, flameMask);
    finalAlpha = max(finalAlpha, flameMask);

    // Glow
    vec3 renderedGlow = flameColor * glowFactor;
    float glowAlpha = clamp(glowFactor, 0.0, 1.0);
    
    finalColor = max(finalColor, renderedGlow);
    finalAlpha = max(finalAlpha, max(flameMask, glowAlpha * 0.5));

    fragColor = vec4(finalColor, finalAlpha);
}

