## How to add new/modify existing gradients for this pack?

All of the gradients are located in the [gradients.glsl](assets/retitled_titles/shaders/include/gradients.glsl), and it's quite easy to add new!

Just get all of the RGB HEX codes for the colors you want to add as gradients, then run the [gradient maker script](./gradient_maker.py) (if you have python), enter all of the HEX colors separated by single spaces, copy the output and paste into the previously mentioned [gradients.glsl](assets/retitled_titles/shaders/include/gradients.glsl).  
Add some extra info with comments like the HEX index, name, etc just for the sake of your convenience (they will be VERY helpful when you are trying out different stuff and want, for example, a specific gradient, it will get very tiring to look through all the colors until you think you found the right one, then counting them up to get the index you want to use, then convert it to HEX so you can use it in a command, it's much simpler to just include all of it in a comment (the convention for how to write them is mentioned in the same file as gradients are located))

### Examples

#### 2-Color gradient

Lets's imagine that we want to add this gradient:  
<img src='showcase/gradient_white.png' height=64>  
A nice, gentle white. So:
Open the previously mentioned [gradient maker script](./gradient_maker.py). Enter the HEX codes for the colors of this 2-color gradient, in this case it's `#dab6b0` and `#f6ead5`, so we input `#dab6b0 #f6ead5` into the script. If you will mess up, it will swear at you (aka simply say what you did wrong and tell to try again).
After we did it, the output was this:  

    vec3(0.85,0.71,0.69),  
    vec3(0.96,0.92,0.84),

So we open the [gradients.glsl](assets/retitled_titles/shaders/include/gradients.glsl), go to the very bottom to add this gradient (which is probably already there as you are reading it, as I'm adding it right now as I'm making these instructions, for me it's not there just yet), add the comma at the last `vec3(..., ..., ...)` that doesn't have it right now, paste in the output of the script, and remove the last comma from it's output.   
Make sure that all non-comment lines (aka the ones that DON'T start with the `//`) have a comma at the end, and ONLY the last non-comment line doesn't have a comma. It will break itself if you don't this right.

The last occupied index in `gradients.glsl` is currently `0x20`, so our index would be `0x21`. No second index is needed as we would only have 2 color gradient.

So, what we have at the end of the `gradients.glsl` file:

    ...,

    // (20) mess  ==  #594c4a #313615
    vec3(0.35,0.30,0.29),
    vec3(0.19,0.21,0.08),

    // (21) gentle white
    vec3(0.85,0.71,0.69),
    vec3(0.96,0.92,0.84)


And we're done! We successfully added it!

#### 4-Color gradient
Now, a really similar process could be applied to gradients of technically any size, (AS LONG AS THEY HAVE AMOUNT OF COLORS THAT ARE A MULTIPLE OF 2!) but we will focus on just 4 since it's the same thing as everything higher than that, except I actually bothered adding fonts that use it.

For example, lets add this now:  
<img src='showcase/gradient_scarlet_violet.png' height=64>  
Let's call it "scarlet violet", since idk why not.

Enter the HEX codes into the script:  
`#ff002d #f00978 #e11bdf #c04aff`

Get output:

    vec3(1.00,0.00,0.18),
    vec3(0.94,0.04,0.47),
    vec3(0.88,0.11,0.87),
    vec3(0.75,0.29,1.00),

paste into the `gradients.glsl`:  

    ...,

    // (20) mess  ==  #594c4a #313615
    vec3(0.35,0.30,0.29),
    vec3(0.19,0.21,0.08),

    // (21) gentle white
    vec3(0.85,0.71,0.69),
    vec3(0.96,0.92,0.84),

    // (22-23) scarlet violet
    vec3(1.00,0.00,0.18),
    vec3(0.94,0.04,0.47),
    vec3(0.88,0.11,0.87),
    vec3(0.75,0.29,1.00)

_Note: we used 2 ideces here, since it's a 4-color gradient, and it's best to write as many indeces as there is colors divided by 2, for your own convenience._

And, boom, it's ready to go.