//#version 150

// To add new new/configure existing transition functions, go to transition_functions.glsl


// pop from down
case 0x25:
    gl_Position.y += displacement_generic(Color.a) * scaled_gui_scale;
    break;

// slide from up
case 0x26:
    gl_Position.y += displacement_slide_from_up(Color.a) * scaled_gui_scale;
    break;

// shake
case 0x27:
    gl_Position.x += rand(GameTime) * scaled_gui_scale * 0.015625;
    gl_Position.y += rand(GameTime + 2.535457) * scaled_gui_scale * 0.015625;
    break;

// shake + slide from up
case 0x28:
    gl_Position.y += (displacement_slide_from_up(Color.a) + rand(GameTime + 2.535457) * 0.015625) * scaled_gui_scale;
    gl_Position.x += rand(GameTime) * 0.015625 * scaled_gui_scale;
    break;

// slide from down
case 0x29:
    gl_Position.y += displacement_slide_from_down(Color.a) * scaled_gui_scale;
    break;

// elastic pop from down
case 0x2A:
    gl_Position.y += displacement_elastic_pop_from_down(Color.a) * scaled_gui_scale;
    break;

// slide from left
case 0x2B:
    gl_Position.x += displacement_slide_from_down(Color.a) * scaled_gui_scale;
    break;

// slide from right
case 0x2C:
    gl_Position.x += displacement_slide_from_up(Color.a) * scaled_gui_scale;
    break;

// double overshoot from up (ugly)
case 0x2D:
    gl_Position.y += double_overshoot(Color.a) * scaled_gui_scale;
    break;

// BDRRRDRDRDIWAUTXUAWYXA
case 0x2E:
    gl_Position.y -= violence(Color.a) * scaled_gui_scale;
    break;

// makes so text finishes appearing before the funcation done it's job
case 0x2F:
    gl_Position.y += smooth_ease(Color.a) * scaled_gui_scale;
    vertexColor.a = min(1.0, vertexColor.a*2.0);

// any value that wasn't assigned anything will result in text being static.