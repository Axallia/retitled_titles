//#version 150

// To chance what transition function applies to what transition ID, go to configured_transitions.glsl


// NOTE: it's best to make it so at the factor of 1.0, function results in 0.0
// and make the rest of the text offset using font's accent
// (tho exception can be made if you are pissed that fonts can't have accent bigger than hight, that's annoying lol)

#define pi  3.141592653589793
#define tau 6.283185307179586
#define sixteen_pi_because_yes 50.26548245743669

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

float displacement_elastic_pop_from_down(float factor) {
    return pow(2.0, -10.0 * factor) * sin((factor * 10.0 - 0.75) * 2.0943951023931953);
}

float double_overshoot(float t) {
    float a = sin(t*t * tau);
    float b = 1.0 - t*1.5;
    b = (1.0 - b * b)*2.6666666666666665;
    return (a+b)*0.5 - 1.0;
}

float violence(float t) {
    float a = sin(pow(t, 5.0) * sixteen_pi_because_yes);
    float b = 1.0 - t*1.5;
    b = (1.0 - b * b)*2.6666666666666665;
    return (a+b)*0.5 - 1.0;
}

float smooth_ease(float t) {
    float a = (1.0 - t);
    a *= a;
    return -a*a;
}