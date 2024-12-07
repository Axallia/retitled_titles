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
    vec3(1.0, 0.9803921568627451,  0.33725490196078434),
    vec3(1.0, 0.47058823529411764, 0.12941176470588237),

    vec3(0.03529411764705882, 0.49019607843137253, 0.6666666666666666),
    vec3(0.4117647058823529,  0.9568627450980393,  0.796078431372549),

    vec3(0.6470588235294118, 0.0, 0.7215686274509804),
    vec3(1.0, 0.20784313725490197, 0.5333333333333333),

    vec3(0.6039215686274509, 0.8862745098039215, 0.30196078431372547),
    vec3(0.15294117647058825, 0.592156862745098, 0.23137254901960785),

    vec3(1.0, 0.9921568627450981, 0.9529411764705882),
    vec3(0.8235294117647058, 0.5372549019607843, 0.8431372549019608),

    vec3(1.2, 0.0, 0.2),
    vec3(-0.1, -0.2, 0.0),
    //#630081
    //c07356

    vec3(0.4980392156862745, 0.0196078431372549, 0.5882352941176471),
    vec3(0.3568627450980392, 0.2823529411764706, 0.807843137254902),
    vec3(0.32941176470588235, 0.8274509803921568, 0.9725490196078431),
    vec3(0.615686274509804, 1.0, 0.6745098039215687),

    vec3(0.3686274509803922, 0.011764705882352941, 0.4666666666666667),
    vec3(0.5725490196078431, 0.17254901960784313, 0.3803921568627451),
    vec3(0.8745098039215686, 0.5647058823529412, 0.27450980392156865),
    vec3(1.0, 0.9098039215686274, 0.3058823529411765)
);

// don't ask, I don't know either. I messed with values until something worked, as always.
float mod_gradient_offset(float _in) {
    return _in >= 0.5 ? _in - 0.001 : _in;
}


in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 window_position;

out vec4 fragColor;

void main() {
    vec4 texture_color = texture(Sampler0, texCoord0);
    if (texture_color.a < 0.001) {
        discard;
    }

    if ( approx_match(vertexColor.rg, vec2(0.1450980392156863, 1.0), 0.1) ) {
        // that cool transition
        if ( !(texture_color.r >= 1.0-vertexColor.a) ) { discard; }

        int gradient_index = int( fract(vertexColor.b*2.0 + mod_gradient_offset(texture_color.g)) * 255.0)/* * 2*/;

        fragColor = vec4(
            mix(GRADIENTS[gradient_index], GRADIENTS[gradient_index+1], texture_color.b),
            1.0
        );

        int effect_ID = int(vertexColor.r * 255.0);
        switch (effect_ID) {
            // that blocky noise thing
            case 40:
            fragColor.rgb += vec3(rand_blocky_canvas(window_position, GameTime)) * texture_color.b;
        }

        return;
    }

    vec4 color = texture_color * vertexColor * ColorModulator;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
