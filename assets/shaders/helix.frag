#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;      // 0
uniform float uTime;     // 1
uniform float uRadius;   // 2
uniform float uWidth;    // 3
uniform vec3 uColor1;    // 4
uniform vec3 uColor2;    // 5
uniform float uParam1;   // 6 - Frequency
uniform float uParam2;   // 7 - Amplitude
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
    
    // Correct Box Size
    vec2 boxSize = (uSize * 0.5) - vec2(uExtraPad) - vec2(uWidth * 0.5);
    
    float minDim = min(boxSize.x, boxSize.y);
    float safeRadius = min(uRadius, minDim);

    float d = sdRoundedBox(center, boxSize, safeRadius);
    float u = getArcLength(center, boxSize, safeRadius);
    
    // --- HELIX LOGIC ---
    float sx = boxSize.x - safeRadius;
    float sy = boxSize.y - safeRadius;
    float perimeter = 4.0 * (sx + sy) + 6.283185 * safeRadius;
    
    float freqMult = uParam1 > 0.1 ? uParam1 : 4.0;
    float targetWavelength = uWidth * freqMult;
    float count = round(perimeter / targetWavelength);
    if (count < 1.0) count = 1.0;
    float exactWavelength = perimeter / count;
    
    float ampRatio = uParam2 > 0.0 ? uParam2 : 0.5;
    float amplitude = uWidth * ampRatio;

    float phaseBase = (u / exactWavelength) * 6.283185 - uTime * 3.0;
    
    // Strand 1
    float off1 = sin(phaseBase) * amplitude;
    float d1 = length(vec2(d - off1, 0.0)); // Simple distance approximation
    
    // Strand 2 (Offset by PI)
    float off2 = sin(phaseBase + 3.14159) * amplitude;
    float d2 = length(vec2(d - off2, 0.0));

    // Depth simulation (Z-index)
    // When cos(phase) is positive, Strand 1 is "in front"
    float depth1 = cos(phaseBase) * 0.5 + 0.5; // 0..1
    float depth2 = cos(phaseBase + 3.14159) * 0.5 + 0.5; // 0..1
    
    // Thickness modulation based on depth
    float baseThick = uWidth * 0.3;
    float thick1 = baseThick * (0.6 + 0.4 * depth1);
    float thick2 = baseThick * (0.6 + 0.4 * depth2);

    // Masks
    float mask1 = 1.0 - smoothstep(thick1 - 0.5, thick1 + 0.5, d1);
    float mask2 = 1.0 - smoothstep(thick2 - 0.5, thick2 + 0.5, d2);
    
    // Composite Strands
    // We mix them. Since they cross, max() works well.
    float coreMask = max(mask1, mask2);
    
    // --- COLOR ---
    // Modulate brightness based on depth
    vec3 col1 = uColor1 * (0.5 + 0.5 * depth1);
    vec3 col2 = uColor1 * (0.5 + 0.5 * depth2); // Both same color, or use uColor2 for second strand?
    // Let's use uColor1 for both but dim the back one to sell the 3D effect.
    
    vec3 pixelColor = vec3(0.0);
    if (mask1 > mask2) {
        pixelColor = col1;
    } else {
        pixelColor = col2;
    }
    
    // Smooth blending at intersection? 
    // Simple max logic for solid shapes:
    pixelColor = max(col1 * mask1, col2 * mask2);

    // --- GLOW ---
    float glowFactor = 0.0;
    if (uGlow > 0.0) {
        float distToClosest = min(d1, d2);
        float falloff = 0.05 / (uGlow * 0.5 + 0.5);
        glowFactor = exp(-falloff * distToClosest * distToClosest) * uGlow * 2.0;
    }

    // Apply Glow to Color
    vec3 glowColor = uColor1; // Glow is always the base color
    if (uGlow > 0.5) glowColor = mix(glowColor, vec3(1.0), (uGlow - 0.5) * 0.5);
    
    // Boost core brightness with glow
    if (uGlow > 0.0) pixelColor *= (1.0 + uGlow);

    // --- OUTPUT ---
    vec3 finalColor = vec3(0.0);
    float finalAlpha = 0.0;

    // Background
    finalColor += uColor2 * coreMask; // Background fills the strands? Maybe better as solid bg behind.
    // Let's make uColor2 strictly background behind everything
    // But we need a mask for the background. Let's use the coreMask.
    // Actually, background usually fills the box. 
    // For these fancy borders, usually uColor2 is unused or fills the gaps.
    // Let's ignore uColor2 for the helix structure itself to keep it clean.
    
    finalColor = pixelColor;
    finalAlpha = coreMask;

    // Add Glow
    vec3 renderedGlow = glowColor * glowFactor;
    float glowAlpha = clamp(glowFactor, 0.0, 1.0);
    
    finalColor = max(finalColor, renderedGlow);
    finalAlpha = max(finalAlpha, max(coreMask, glowAlpha * 0.5));

    fragColor = vec4(finalColor, finalAlpha);
}

