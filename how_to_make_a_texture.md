## How to make a custom font texture for this pack?

They are just regular font textures, but with extra info encoded in their color:  
> **Red**: <br>
  basically drives at what stage should pixel be shown.
  the higher values mean the earlier in animation text
  should be for pixel it to be shown.  

> **Green**: <br>
  is a gradient offset. adding 1 to green will shift the selected gradient 0.5
  (intended behavior, so you can chain several gradients in a more space-efficient way.)
  also values above 127 are treated like negatives (255 is -1, 180 is -76, etc (computed by: `value - 256`)).  

> **Blue**: <br> 
  is a "**gradient factor**" in a sense, drives how top and bottom gradient colors
  should be mixed in the final output.  

_**Note**: it's easier to draw the pure black base first, and then make 3 pure black / transparent layers (or even better folders),
all set to be clipped onto the layer below, and all set to be in `addition` blending mode,
and paint each component separately with an airbrush, gradient tool, or whatever you are most comfortable with._

<br>

### 3-colored gradients

To include several colors in 1 gradient (like it is in `decor-4`), you technically already have the information
needed to do so (assuming you didn't skip the part above).
But, to do that in a seamless way could be tricky, so here is how you could simplify this process for 3-colored gradients:  

1. draw your gradient factor as usual.
2. add a layer of solid color [0, 0, 127], set blending mode it to `modulo`
3. copy that layer, set blending mode to `divide`
4. copy the initial gradient factor layer, make sure that it's black&white, apply a sharp gradient to it, with values less than or euqal to 127 will result in pure black, and values higher than that will be mapped to [0, 1, 0], and set this layer's (or probably folder's) blending mode to `addition`.

It should work, at least it did for me (I used Krita btw, so some features above might be missing in program of your choice,
then you gonna need to develop your own procedure)