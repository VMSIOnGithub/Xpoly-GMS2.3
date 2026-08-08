//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D surface1;
uniform sampler2D surface2;

void main() {
    vec4 col1 = texture2D(surface1, v_vTexcoord);
    vec4 col2 = texture2D(surface2, v_vTexcoord);
    
    float a1 = col1.a;
    float a2 = col2.a;
    
    float unionAlpha = max(a1, a2);
    
    float intersectAlpha = a1 * a2;
    
    float xorAlpha = unionAlpha - intersectAlpha;
    
    gl_FragColor = vec4(1.0, 1.0, 1.0, xorAlpha);
}