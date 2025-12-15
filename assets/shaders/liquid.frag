#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;      // 0
uniform float uTime;     // 1
uniform float uRadius;   // 2
uniform float uWidth;    // 3
uniform vec3 uColor1;    // 4
uniform vec3 uColor2;    // 5
uniform float uParam1;   // 6 - Blob Frequency
uniform float uParam2;   // 7 - Blob Speed/Fluidity
uniform float uGlow;     // 8
uniform float uExtraPad; // 9

out vec4 fragColor;

float sdRoundedBox(vec2 p, vec2 b, float r) {
    vec2 q = abs(p) - b + vec2(r);
    return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - r;
}

float getArcLength(vec2 p, vec2 boxSize, float r) {
    float sx = boxSize.x - r;
    float sy = boxSize.y - r;
    float topDist = sx;
    float cornerDist = 1.570796 * r;
    float sideDist = 2.0 * sy;
    float bottomDist = 2.0 * sx;
    float dist = 0.0;
    
    if (p.x > sx) {
        if (p.y < -sy) {
            vec2 rel = p - vec2(sx, -sy);
            float a = atan(rel.y, rel.x);
            dist = topDist + (a + 1.570796) * r;
        } else if (p.y > sy) {
            float start = topDist + cornerDist + sideDist;
            vec2 rel = p - vec2(sx, sy);
            float a = atan(rel.y, rel.x);
            dist = start + a * r;
        } else {
            float start = topDist + cornerDist;
            dist = start + (p.y - (-sy)); 
        }
    } else if (p.x < -sx) {
        if (p.y > sy) {
            float start = topDist + cornerDist + sideDist + cornerDist + bottomDist;
            vec2 rel = p - vec2(-sx, sy);
            float a = atan(rel.y, rel.x);
            dist = start + (a - 1.570796) * r;
        } else if (p.y < -sy) {
            float start = topDist + cornerDist + sideDist + cornerDist + bottomDist + cornerDist + sideDist;
            vec2 rel = p - vec2(-sx, -sy);
            float a = atan(rel.y, rel.x);
            dist = start + (a + 3.141592) * r;
        } else {
            float start = topDist + cornerDist + sideDist + cornerDist + bottomDist + cornerDist;
            dist = start + (sy - p.y);
        }
    } else {
        if (p.y < 0.0) {
            dist = p.x;
        } else {
            float start = topDist + cornerDist + sideDist + cornerDist;
            dist = start + (sx - p.x);
        }
    }
    return dist;
}

void main() {
    vec2 pos = FlutterFragCoord().xy;
    vec2 center = pos - uSize * 0.5;
    
    vec2 boxSize = (uSize * 0.5) - vec2(uExtraPad) - vec2(uWidth * 0.5);
    
    float minDim = min(boxSize.x, boxSize.y);
    float safeRadius = min(uRadius, minDim);

    float d = sdRoundedBox(center, boxSize, safeRadius);
    float u = getArcLength(center, boxSize, safeRadius);
    
    // --- LIQUID LOGIC ---
    // We vary the thickness based on u.
    // Liquid Thickness = Base + Noise(u, time)
    
    float sx = boxSize.x - safeRadius;
    float sy = boxSize.y - safeRadius;
    float perimeter = 4.0 * (sx + sy) + 6.283185 * safeRadius;
    
    float freqMult = uParam1 > 0.1 ? uParam1 : 3.0;
    float speedMult = uParam2 > 0.0 ? uParam2 : 1.0;
    
    // To make it seamless, we need integer cycles
    float targetWavelength = uWidth * freqMult * 10.0; // Longer blobs
    float count = round(perimeter / targetWavelength);
    if (count < 1.0) count = 1.0;
    float exactWavelength = perimeter / count;
    
    float phase = (u / exactWavelength) * 6.283185;
    
    // Blob shape: Sin + Sin(2x) to make it organic
    float blob = sin(phase - uTime * 2.0 * speedMult) 
               + 0.5 * sin(phase * 2.0 + uTime * 3.0 * speedMult)
               + 0.3 * sin(phase * 3.5 - uTime * 1.5 * speedMult);
               
    // Normalize roughly to -1..1 range
    blob *= 0.5; 
    
    // Modulate thickness
    // If blob > threshold, we have liquid.
    // We want pinch-off effect.
    float threshold = 0.2;
    float liquidWidth = smoothstep(threshold - 0.5, threshold + 0.5, blob + 0.5); 
    // This gives varying width 0..1
    
    float currentThickness = uWidth * (0.2 + 0.8 * liquidWidth); // Min 20%, Max 100%
    
    // Core Mask
    float dist = abs(d);
    float coreMask = 1.0 - smoothstep(currentThickness * 0.5 - 0.5, currentThickness * 0.5 + 0.5, dist);

    // Color
    vec3 activeColor = uColor1;
    // Vary color slightly with blob thickness for depth
    activeColor *= (0.8 + 0.4 * liquidWidth);
    
    if (uGlow > 0.0) {
        activeColor *= (1.0 + uGlow * 2.0);
        if (uGlow > 0.5) activeColor = mix(activeColor, vec3(1.0), (uGlow - 0.5) * 0.5);
    }
    
    // Glow
    float glowFactor = 0.0;
    if (uGlow > 0.0) {
        float falloff = 0.05 / (uGlow * 0.5 + 0.5);
        // Glow radiates from the liquid mass
        glowFactor = exp(-falloff * dist * dist) * uGlow * 2.0 * liquidWidth;
    }

    vec3 finalColor = vec3(0.0);
    float finalAlpha = 0.0;

    // Background
    finalColor += uColor2 * coreMask;
    finalAlpha = max(finalAlpha, coreMask);

    // Liquid Core
    finalColor = mix(finalColor, activeColor, coreMask);
    finalAlpha = max(finalAlpha, coreMask);

    // Glow
    vec3 renderedGlow = activeColor * glowFactor;
    float glowAlpha = clamp(glowFactor, 0.0, 1.0);
    
    finalColor = max(finalColor, renderedGlow);
    finalAlpha = max(finalAlpha, max(coreMask, glowAlpha * 0.5));
    
    fragColor = vec4(finalColor, finalAlpha);
}

