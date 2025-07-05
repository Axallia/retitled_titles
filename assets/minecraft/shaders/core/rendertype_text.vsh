#version 330

#moj_import <minecraft:fog.glsl>
#moj_import <retitled_titles:utils.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;
uniform float GameTime;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

flat out int obj_type;

#moj_import <retitled_titles:transition_functions.glsl>

void main() {

    bool is_monochromatic = ((Color.r - Color.g) == 0.0) && ((Color.b - Color.g) == 0.0);
    if ( approx_match(Color.g, 135.0 / 255.0, 0.02) && !is_monochromatic ) {
        vertexColor = Color;
        texCoord0 = UV0;
        vertexDistance = 0.0;
        float guiScale = (round(ScreenSize.x * ProjMat[0][0] / 2));
        float scaled_gui_scale = guiScale*0.3333;

        gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

        //obj_type = 0;
        //vertexColor = vec4(
        //    guiScale*255.0, 
        //    ((1.0 > -guiScale) && (-guiScale >= 4.0)) ? 1.0 : 0.0,
        //    guiScale == 0.0 ? 1.0 : 0.0,
        //    1.0
        //);
        //return;


        float adjustment_type = (Color.g * 255.0 - 134.0);
        if (adjustment_type < 1.0) {
            switch (int(adjustment_type)){
                // actionbar
                case 0:
                gl_Position.xy *= 0.25;
                gl_Position.y += -1.0 + 123.5/ScreenSize.y*guiScale;
                break;

                // top
                case -1:
                gl_Position.xy *= 0.5;
                gl_Position.y += 1.0 - 100.0/ScreenSize.y*guiScale;
                break;

                // top right-ish
                case -2:
                gl_Position.xy *= 0.25;
                gl_Position.y += 1.0 - 100.0/ScreenSize.y*guiScale;
                gl_Position.x += 1.0 - 100.0/ScreenSize.x*guiScale;
                break;
            }
        } else {
            float text_scale = 1.0 / adjustment_type;
            gl_Position.xy *= text_scale;
        }
        
        
        int effect_ID = int(Color.r * 255.0);
        // yes I know, it's kinda messy but we didn't got function pointers in glsl cus gpus are kinda stupod so yeah
        switch (effect_ID) {
#moj_import <retitled_titles:configured_transitions.glsl>
        }

        obj_type = 16; // title text
        return;
    }

    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    // comment out this part if you want to disable all text having little pop animation
    // or replace the function with whatever your heart desires, to change the default transition
    gl_Position.y += displacement_generic(Color.a);


    vertexDistance = fog_distance(Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
    obj_type = 0;  // regular text
}
