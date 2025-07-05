
def validate_hex(hex_:str) -> bool:
    hex_len:int = len(hex_)
    if hex_len == 0:
        print('<!> Two consecutive space detected; please try again.')
        return False
    if hex_len > 6:
        print('<!> Hex codes cannot be longer than 6 characters; please try again.')
        return False
    
    for char in hex_:
        if not char in "0123456789abcdefABCDEF":
            print(f'<!> Invalid HEX color code "{hex_}", hex format cannot contain character "{char}"; please try again.')
            return False
    return True

def main() -> None:
    print (
        '\n -= gradient maker =-',
        'enter "exit" when you are done.',
        'enter any amount of colors in HEX format (separate by single spaces), and the script will generate something to put into a shader!',
        '(it won\'t generate the comments tho, you will need to make them yourself)',
        'Also, don\'t forget to fix the commas!!!', 
    sep='\n')

    is_valid:bool = True
    while True:
        print('')
        _input:str = input('> ').strip()
        if _input == 'exit': break
        raw_colors_list:list[str] = [v.strip('#') for v in _input.split(' ')]
        colors_list:list[tuple[float,float,float]] = []
        for raw_color in raw_colors_list:
            is_valid = validate_hex(raw_color)
            if not is_valid: break

            single_int:int = int(raw_color, base=16)
            red:float =   ((single_int >> 16) & 255) / 255.0
            green:float = ((single_int >> 8 ) & 255) / 255.0
            blue:float =  ((single_int      ) & 255) / 255.0
            colors_list.append((red,green,blue))
        if not is_valid: continue
        
        for color in colors_list:
            print(f'vec3({color[0]:.2f},{color[1]:.2f},{color[2]:.2f}),')
        
        #action:str = input('\nContinue? y/n > ')
        #if action != 'y': break

if __name__ == '__main__':
    main()