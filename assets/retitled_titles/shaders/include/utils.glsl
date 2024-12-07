#version 150

bool approx_match(float first, float second, float threshold) {
    return abs(first - second) <= threshold;
}

bool approx_match(vec2 first, vec2 second, float threshold) {
    return (
        (abs(first.x - second.x) <= threshold) &&
        (abs(first.y - second.y) <= threshold)
    );
}

bool approx_match(vec3 first, vec3 second, float threshold) {
    return (
        abs(first.x - second.x) <= threshold &&
        abs(first.y - second.y) <= threshold &&
        abs(first.z - second.z) <= threshold
    );
}

// yes ik I could've looked a better function up on the internet,
// and I did try to do it at first but then after 7 minutes got lazy
// and then said good "eh, good enough" to this one.
float rand(float _in) {
    _in = fract(_in * 0.2) * 27.2753;
    float add = float( int(_in * 1649) ^ 20469 ) * 0.3713330857779428;
    return fract(_in * _in * 691.3261357456 + add) - 0.5;
}

// alotta useless math that prob could be simplified letssss gooooo 
float rand_blocky_canvas(vec2 coords, float offset) {
    float spacing = rand(ceil((coords.y + fract(offset*64136.6469969) * 39.2864535) * 152.0) * 0.03);
    float disrupt = rand(ceil((coords.x + spacing) * 233.35465*max(1-spacing*spacing, 0.125)));
    spacing = fract(disrupt + spacing);
    spacing *= spacing;
    float dots = rand((coords.x)*35242.7328);
    if (dots > 0.4) {
        spacing = -spacing;
    }

    return spacing;
}