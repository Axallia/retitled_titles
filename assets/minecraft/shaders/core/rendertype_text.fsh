#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <retitled_titles:utils.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;


const vec3[] GRADIENTS = vec3[](
    #moj_import <retitled_titles:gradients.glsl>
);

// don't ask, I don't know either. I messed with values until something worked, as always.
float mod_gradient_offset(float _in) {
    return _in >= 0.5 ? _in - 0.001 : _in;
}


in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
flat in int obj_type;

out vec4 fragColor;

void main() {
    vec4 texture_color = texture(Sampler0, texCoord0);
    if (texture_color.a < 0.001) {
        discard;
    }

    if ( obj_type == 16 ) {
        // that cool transition
        if ( !(texture_color.r >= 1.0-vertexColor.a) ) discard;

        int gradient_index = int( fract(vertexColor.b*2.0 + mod_gradient_offset(texture_color.g)) * 255.0);

        fragColor = vec4(
            mix(GRADIENTS[gradient_index], GRADIENTS[gradient_index+1], texture_color.b),
            1.0
        );

        int effect_ID = int(vertexColor.r * 255.0);
        switch (effect_ID) {
            // that blocky noise thing
            case 40:
            fragColor.rgb += vec3(rand_blocky_canvas(gl_FragCoord.xy, GameTime)) * texture_color.b;
        }

        return;
    }

    // vanilla text
    vec4 color = texture_color * vertexColor * ColorModulator;
    //vec4 color = vertexColor;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
