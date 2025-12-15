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

    float halfWidth = uWidth * 0.5;
    float coreThickness = halfWidth * 0.5; 

    float dist = abs(d);
    float coreMask = 1.0 - smoothstep(coreThickness - 0.5, coreThickness + 0.5, dist);

    float u = getArcLength(center, boxSize, safeRadius);
    float sx = boxSize.x - safeRadius;
    float sy = boxSize.y - safeRadius;
    float perimeter = 4.0 * (sx + sy) + 6.283185 * safeRadius;
    
    float spacingMult = uParam1 > 0.1 ? uParam1 : 4.0;
    float targetSpacing = uWidth * spacingMult;
    float count = round(perimeter / targetSpacing);
    if (count < 1.0) count = 1.0;
    float exactSpacing = perimeter / count;
    
    float animU = u - uTime * 50.0;
    float localU = (fract(animU / exactSpacing) - 0.5) * exactSpacing;
    float distToDotCenter = length(vec2(localU, d));
    
    float maxRadius = exactSpacing * 0.4;
    float nominalRadius = uWidth * 0.35;
    float dotRadius = min(nominalRadius, maxRadius);
    
    float dotMask = 1.0 - smoothstep(dotRadius - 0.5, dotRadius + 0.5, distToDotCenter);

    vec3 activeColor = uColor1;
    if (uGlow > 0.0) {
        activeColor *= (1.0 + uGlow * 1.5);
        if (uGlow > 0.5) activeColor = mix(activeColor, vec3(1.0), (uGlow - 0.5) * 0.5);
    }
    
    float glowFactor = 0.0;
    if (uGlow > 0.0) {
        float falloff = 0.05 / (uGlow * 0.5 + 0.5);
        glowFactor = exp(-falloff * distToDotCenter * distToDotCenter) * uGlow * 2.0;
    }

    vec3 finalColor = vec3(0.0);
    float finalAlpha = 0.0;

    finalColor += uColor2 * coreMask;
    finalAlpha = max(finalAlpha, coreMask);

    finalColor = mix(finalColor, activeColor, coreMask * dotMask);
    finalAlpha = max(finalAlpha, coreMask * dotMask);

    vec3 renderedGlow = activeColor * glowFactor;
    float glowAlpha = clamp(glowFactor, 0.0, 1.0);
    
    finalColor = max(finalColor, renderedGlow);
    finalAlpha = max(finalAlpha, max(coreMask * dotMask, glowAlpha * 0.5));
    
    fragColor = vec4(finalColor, finalAlpha);
}
