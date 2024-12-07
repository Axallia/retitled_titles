## How to use
# In text color encoded:
# Red:
# - has to be in range from 12 to 62 in order for the shader to trigger.
# - changes what displacement animation to apply (generic, slide from down, none, vibrating, a custom one, etc)
#   (for details what if what look it up in vertex shader)
# Green:
# - has to be in range from 230 to 255* in order for the shader to trigger.
# - does not encode anything for now.
# Blue:
# - does not change whether to trigger the shader or not 
# - drives what gradient (or set of gradients, depending on the font) to apply.
#   adding 1 to blue, will shift the chosen gradient by 1.

## Examples:

# default transition (pop from down), flowers decoration, base gradient of index 3 (AKA green)
title @a title {"text":"\uF903\u0003flowers\u0004", "font":"retitled_titles:regular", "color":"#25FF03"}

# slide from up, generic decoration, gradient of index 0 (AKA gold)
title @a title {"text":"\uF903\u0001act 69\u0002", "font":"retitled_titles:regular", "color":"#26FF00"}

# slide from down, fruity decoration, gradient index of 4 (AKA white-ish)
title @a title {"text":"\uF903\u0005fruits\u0006", "font":"retitled_titles:regular", "color":"#29FF04"}

# severe ADHD (AKA vibrating), no decoration, gradient of index 1 (AKA aqua)
title @a title {"text":"aaaaaaa", "font":"retitled_titles:regular", "color":"#27FF01"}

# vibrating slide from up, generic decoration, gradient index of 5 (AKA corrupted red)
title @a title {"text":"\uF902\u0001shall the fight begin\u0002", "font":"retitled_titles:regular", "color":"#28FF05"}

# no animation, enclosed gem decor, gradient of index 4 (AKA white-ish)
title @a title {"text":"\uF902\u0007cute\u0008", "font":"retitled_titles:regular", "color":"#24FF04"}

# default transition (pop from down), untitled decoration, base gradient of index 8 (AKA purple-red-yellow)
title @a title {"text":"\uF903\u0009RETITLED TITLES\u000A", "font":"retitled_titles:regular", "color":"#25FF08"}