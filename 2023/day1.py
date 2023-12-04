def get_digit(line, idx):
    if line[idx].isdigit():
        return line[idx]

    str_digits = {
        'one': '1',
        'two': '2',
        'three': '3',
        'four': '4',
        'five': '5',
        'six': '6',
        'seven': '7',
        'eight': '8',
        'nine': '9'
    }
    for key, val in str_digits.items():
        if line[idx:(idx + len(key))] == key:
            return val
    
    return None

with open("input.txt") as f:
    contents = f.read()

lines = contents.split('\n')
count = 0
for line in lines:
    calibration = ''
    is_first = True
    digit = None
    for idx in range(len(line)):
        result = get_digit(line, idx)
        if result is not None:
            digit = result
            if is_first:
                calibration += digit
                is_first = False
    calibration += digit
    count += int(calibration)

print(count)
