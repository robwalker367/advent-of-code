
def is_symbol(cell):
    return not cell.isdigit() and cell != '.'
    
def get_is_part(matrix, row_idx, col_idx):
    for i in range(max([0, row_idx - 1]), min([len(matrix), row_idx + 2])):
        for j in range(max([0, col_idx - 1]), min([len(matrix[0]), col_idx + 2])):
            if is_symbol(matrix[i][j]):
                return True
    return False

with open('input.txt') as f:
    contents = f.read()

matrix = contents.split('\n')
count = 0
    
width, height = len(matrix[0]), len(matrix)
for row_idx in range(height):
    current_number = 0
    is_part = False
    for col_idx in range(width):
        cell = matrix[row_idx][col_idx]
            
        if cell.isdigit():
            if not is_part:
                is_part = get_is_part(matrix, row_idx, col_idx)
            current_number = current_number * 10 + int(cell)
        else:
            if current_number != 0 and is_part:
                count += current_number
            current_number = 0
            is_part = False

    if is_part:
        count += current_number
        is_part = False

print(count)
