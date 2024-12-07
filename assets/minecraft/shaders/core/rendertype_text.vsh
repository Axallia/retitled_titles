#version 150

#moj_import <retitled_titles:utils.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform float GameTime;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec2 window_position;

// NOTE: it's best to make it so at the factor of 1.0, function results in 0.0
// and make the rest of the text offset using font's accent
// (tho exception can be made if you are pissed that fonts can't have accent bigger than hight, that's annoying lol)
float displacement_generic(float factor) {
    float two_factors = factor * 2.0;
    return 0.125 * (3.0 * factor - 0.5 * two_factors * two_factors - 1.0);
}

float displacement_slide_from_up(float factor) {
    return (factor * factor) - (2.0 * factor) + 1.0;
}

float displacement_slide_from_down(float factor) {
    return -(factor * factor) + (2.0 * factor) - 1.0;
}


void main() {

    if ( approx_match(Color.rg, vec2(0.03529411764705882, 0.24313725490196078), 0.01) ) {
        gl_Position = vec4(0.0);
        return;
    }

    if ( approx_match(Color.rg, vec2(0.1450980392156863, 1.0), 0.1) ) {
        vertexColor = Color;
        texCoord0 = UV0;
        vertexDistance = 0.0;

        gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
        int effect_ID = int(Color.r * 255.0);
        // yes ik it's messy but we didn't got function pointers in glsl cus gpus are kinda stupod so yeah
        switch (effect_ID) {
        case 37:
            gl_Position.y += displacement_generic(Color.a);
            break;
        case 38:
            gl_Position.y += displacement_slide_from_up(Color.a);
            break;
        case 39:
            gl_Position.x += rand(GameTime) * 0.015625;
            gl_Position.y += rand(GameTime + 2.535457) * 0.015625;
            break;
        case 40:
            gl_Position.y += displacement_slide_from_up(Color.a) + rand(GameTime + 2.535457) * 0.015625;
            gl_Position.x += rand(GameTime) * 0.015625;
            break;
        case 41:
            gl_Position.y += displacement_slide_from_down(Color.a);
            break;
        }

        window_position = gl_Position.xy;
        return;
    }

    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    // comment this part if you want to disable all text having little pop animation
    // or replace the function with whatever your heart desires, to change the default transition
    gl_Position.y += displacement_generic(Color.a);


    vertexDistance = length((ModelViewMat * vec4(Position, 1.0)).xyz);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
}
