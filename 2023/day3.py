def get_idx(matrix, row_idx, col_idx):
    if row_idx < 0 or len(matrix) <= row_idx or col_idx < 0 or len(matrix[0]) <= col_idx:
        return ''
    return matrix[row_idx][col_idx]

def construct_num(matrix, row, col):
    num = int(matrix[row][col])
    left = col - 1
    while get_idx(matrix, row, left).isdigit():
        num = num + ((10 ** (col - left)) * int(get_idx(matrix, row, left)))
        left -= 1
    right = col + 1
    while get_idx(matrix, row, right).isdigit():
        num = num * 10 + int(get_idx(matrix, row, right))
        right += 1
    return num

def get_gear_nums(matrix, row_idx, col_idx):
    nums = []
    for i in range(max([0, row_idx - 1]), min([len(matrix), row_idx + 2])):
        for j in range(max([0, col_idx - 1]), min([len(matrix[0]), col_idx + 2])):
            if matrix[i][j].isdigit():
                num = construct_num(matrix, i, j)
                nums.append(num)
    return nums

def get_row_num_count(matrix, row_idx, col_idx):
    count = 0
    l = get_idx(matrix, row_idx, col_idx - 1)
    e = get_idx(matrix, row_idx, col_idx)
    r = get_idx(matrix, row_idx, col_idx + 1)
    if l.isdigit() and not e.isdigit() and r.isdigit():
        count += 2
    elif l.isdigit() and e.isdigit() and not r.isdigit():
        count += 1
    elif not l.isdigit() and e.isdigit() and r.isdigit():
        count += 1
    elif l.isdigit() or e.isdigit() or r.isdigit():
        count += 1
    return count

def get_gear_num_count(matrix, row_idx, col_idx):
    count = 0
    if get_idx(matrix, row_idx, col_idx - 1).isdigit():
        count += 1
    if get_idx(matrix, row_idx, col_idx + 1).isdigit():
        count += 1

    count += get_row_num_count(matrix, row_idx - 1, col_idx)

    count += get_row_num_count(matrix, row_idx + 1, col_idx)
    
    return count


with open('input.txt') as f:
    contents = f.read()

matrix = contents.split('\n')
count = 0
width, height = len(matrix[0]), len(matrix)
for row_idx in range(height):
    for col_idx in range(width):
        cell = matrix[row_idx][col_idx]
        gear_num_count = get_gear_num_count(matrix, row_idx, col_idx)
        if cell == '*' and gear_num_count == 2:
            nums = get_gear_nums(matrix, row_idx, col_idx)
            nums = list(set(nums))
            count += nums[0] * nums[1]

print(count)
