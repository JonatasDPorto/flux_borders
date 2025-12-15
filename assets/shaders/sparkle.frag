#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;      // 0
uniform float uTime;     // 1
uniform float uRadius;   // 2
uniform float uWidth;    // 3
uniform vec3 uColor1;    // 4
uniform vec3 uColor2;    // 5
uniform float uParam1;   // 6 - Density
uniform float uParam2;   // 7 - Twinkle Speed
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

// Pseudo random
float hash(float n) { return fract(sin(n) * 43758.5453123); }

void main() {
    vec2 pos = FlutterFragCoord().xy;
    vec2 center = pos - uSize * 0.5;
    vec2 boxSize = (uSize * 0.5) - vec2(uExtraPad) - vec2(uWidth * 0.5);
    float minDim = min(boxSize.x, boxSize.y);
    float safeRadius = min(uRadius, minDim);

    float d = sdRoundedBox(center, boxSize, safeRadius);
    float u = getArcLength(center, boxSize, safeRadius);
    
    float halfWidth = uWidth * 0.5;
    float coreThickness = halfWidth * 0.5; 
    float dist = abs(d);
    
    // Core Mask (The wire)
    // Starfield usually has a very thin or invisible wire, and sparkles on top?
    // Let's make the wire very dim, and sparkles bright.
    float coreMask = 1.0 - smoothstep(coreThickness - 0.5, coreThickness + 0.5, dist);

    // --- SPARKLE LOGIC ---
    // Generate sparkles along 'u'
    float density = uParam1 > 0.0 ? uParam1 * 0.5 : 0.5; // Density of sparkles
    
    // Grid along u
    float spacing = 20.0 / density;
    float cell = floor(u / spacing);
    
    float noise = hash(cell);
    float noise2 = hash(cell * 1.23);
    
    // Random position within cell
    float localU = u - (cell * spacing);
    float centerU = spacing * (0.2 + 0.6 * noise); 
    
    // Distance to sparkle center along arc
    float distU = abs(localU - centerU);
    
    // Twinkle animation
    float speed = uParam2 > 0.0 ? uParam2 : 1.0;
    float twinklePhase = uTime * (2.0 + 5.0 * noise2) * speed + noise * 10.0;
    float twinkle = sin(twinklePhase);
    twinkle = pow(max(0.0, twinkle), 4.0); // Sharp flashes
    
    // Star shape (cross) in dist-space? No, just bright spots.
    // Bloom shape based on distU and d
    float distToStar = length(vec2(distU, d));
    
    // Star intensity
    float star = 0.0;
    if (distToStar < uWidth * 2.0) {
        star = (1.0 - smoothstep(0.0, uWidth * 0.5, distToStar)) * twinkle;
    }
    
    // Colors
    vec3 activeColor = uColor1;
    // Dim base
    activeColor *= 0.2; 
    
    // Bright stars
    vec3 starColor = mix(uColor1, vec3(1.0), 0.7); // Mostly white stars
    
    // Mix star into color
    vec3 pixelColor = mix(activeColor, starColor, star);
    
    if (uGlow > 0.0) {
        pixelColor *= (1.0 + uGlow * 2.0);
    }
    
    float glowFactor = 0.0;
    if (uGlow > 0.0) {
        float falloff = 0.05 / (uGlow * 0.5 + 0.5);
        // Glow mostly around stars
        glowFactor = exp(-falloff * distToStar * distToStar) * uGlow * 3.0 * twinkle;
    }

    vec3 finalColor = vec3(0.0);
    float finalAlpha = 0.0;

    // Background
    float bgMask = 1.0 - smoothstep(halfWidth - 0.5, halfWidth + 0.5, dist);
    finalColor += uColor2 * bgMask;
    finalAlpha = max(finalAlpha, bgMask);

    // Core
    finalColor = mix(finalColor, pixelColor, coreMask);
    finalAlpha = max(finalAlpha, coreMask);

    // Glow
    vec3 renderedGlow = starColor * glowFactor;
    float glowAlpha = clamp(glowFactor, 0.0, 1.0);
    
    finalColor = max(finalColor, renderedGlow);
    finalAlpha = max(finalAlpha, max(coreMask, glowAlpha * 0.5));

    fragColor = vec4(finalColor, finalAlpha);
}

