def neighbors8(matrix, row, col):
    for i in range(max([0, row-1]), min(len(matrix), row+2)):
        for j in range(max([0, col-1]), min([len(matrix[0]), col+2])):
            if not (i == row and j == col):
                yield matrix[i][j]

def neighbors8_idx(matrix, row, col):
    for i in range(max([0, row-1]), min(len(matrix), row+2)):
        for j in range(max([0, col-1]), min([len(matrix[0]), col+2])):
            if not (i == row and j == col):
                yield (i, j)

def read_input():
    with open("input.txt") as f:
        contents = f.read()
    return contents
