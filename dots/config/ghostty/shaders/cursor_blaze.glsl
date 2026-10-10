// Constants for colors and animation
vec4 TRAIL_COLOR = iCurrentCursorColor;
vec4 TRAIL_COLOR_ACCENT = iCurrentCursorColor;
// const vec4 TRAIL_COLOR_ACCENT = vec4(1.0, 0.0, 0.0, 1.0); // Red-orange
const float DURATION = 0.5;

// Smoothly interpolate t using a quadratic blend function
float blend(float t) {
    float sqr = t * t;
    return sqr / (2.0 * (sqr - t) + 1.0);
}

// Ease function for animation
float ease(float x) {
    return pow(1.0 - x, 10.0);
}

// Normalize coordinates or sizes to [-1, 1] space based on resolution
vec2 normalize(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

// Signed distance function for a rectangle
float getSdfRectangle(vec2 p, vec2 xy, vec2 b) {
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

// Signed distance function for a line segment
float seg(vec2 p, vec2 a, vec2 b, inout float s, float d) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    float segd = dot(p - proj, p - proj);
    d = min(d, segd);

    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float allCond = c0 * c1 * c2;
    float noneCond = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    float flip = mix(1.0, -1.0, step(0.5, allCond + noneCond));
    s *= flip;
    return d;
}

// Signed distance function for a parallelogram
float getSdfParallelogram(vec2 p, vec2 v0, vec2 v1, vec2 v2, vec2 v3) {
    float s = 1.0;
    float d = dot(p - v0, p - v0);

    d = seg(p, v0, v3, s, d);
    d = seg(p, v1, v0, s, d);
    d = seg(p, v2, v1, s, d);
    d = seg(p, v3, v2, s, d);

    return s * sqrt(d);
}

// Apply antialiasing based on distance
float antialiasing(float distance) {
    return 1.0 - smoothstep(0.0, normalize(vec2(2.0, 2.0), 0.0).x, distance);
}

// Determine the starting vertex factor for parallelogram
float determineStartVertexFactor(vec2 a, vec2 b) {
    float condition1 = step(b.x, a.x) * step(a.y, b.y);
    float condition2 = step(a.x, b.x) * step(b.y, a.y);
    return 1.0 - max(condition1, condition2);
}

// Calculate the center of a rectangle
vec2 getRectangleCenter(vec4 rectangle) {
    return vec2(rectangle.x + rectangle.z / 2.0, rectangle.y - rectangle.w / 2.0);
}

// Main shader function
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Initialize output color from texture
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    // Normalize fragment coordinates
    vec2 uv = normalize(fragCoord, 1.0);
    vec2 offsetFactor = vec2(-0.5, 0.5);

    // Normalize cursor positions and sizes
    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.0), normalize(iCurrentCursor.zw, 0.0));
    vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.0), normalize(iPreviousCursor.zw, 0.0));

    // Determine vertex factor for parallelogram trail
    float vertexFactor = determineStartVertexFactor(currentCursor.xy, previousCursor.xy);
    float invertedVertexFactor = 1.0 - vertexFactor;

    // Define parallelogram vertices
    vec2 v0 = vec2(currentCursor.x + currentCursor.z * vertexFactor, currentCursor.y - currentCursor.w);
    vec2 v1 = vec2(currentCursor.x + currentCursor.z * invertedVertexFactor, currentCursor.y);
    vec2 v2 = vec2(previousCursor.x + currentCursor.z * invertedVertexFactor, previousCursor.y);
    vec2 v3 = vec2(previousCursor.x + currentCursor.z * vertexFactor, previousCursor.y - previousCursor.w);

    // Initialize new color
    vec4 newColor = vec4(fragColor);

    // Calculate animation progress
    float progress = blend(clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0));
    float easedProgress = ease(progress);

    // Calculate distances for trail fading
    vec2 centerCC = getRectangleCenter(currentCursor);
    vec2 centerCP = getRectangleCenter(previousCursor);
    float lineLength = distance(centerCC, centerCP);
    float distanceToEnd = distance(uv, centerCC);
    float alphaModifier = min(distanceToEnd / (lineLength * easedProgress), 1.0);

    // Compute signed distance fields
    float sdfCursor = getSdfRectangle(uv, currentCursor.xy - (currentCursor.zw * offsetFactor), currentCursor.zw * 0.5);
    float sdfTrail = getSdfParallelogram(uv, v0, v1, v2, v3);

    // Apply trail and accent colors
    newColor = mix(newColor, TRAIL_COLOR_ACCENT, 1.0 - smoothstep(sdfTrail, -0.01, 0.001));
    newColor = mix(newColor, TRAIL_COLOR, antialiasing(sdfTrail));

    // Blend with alpha modifier
    newColor = mix(fragColor, newColor, 1.0 - alphaModifier);

    // Apply cursor mask
    fragColor = mix(newColor, fragColor, step(sdfCursor, 0.0));
}
