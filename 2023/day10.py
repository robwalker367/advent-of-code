import helpers

graph = helpers.read_input().split('\n')
N, M = len(graph), len(graph[0])

NORTH, EAST, SOUTH, WEST = 0, 1, 2, 3
pipe_mappings = {
    '|': [True, False, True, False],
    '-': [False, True, False, True],
    'L': [True, True, False, False],
    'J': [True, False, False, True],
    '7': [False, False, True, True],
    'F': [False, True, True, False],
    'S': [True, True, True, True],
    '.': [False, False, False, False]
}

def neighbors4(matrix, i, j):
    neighbors = []
    curr = matrix[i][j]
    # North
    if i - 1 >= 0:
        nxt = matrix[i-1][j]
        if pipe_mappings[curr][NORTH] and pipe_mappings[nxt][SOUTH]:
            neighbors.append((i-1, j))
    
    # East
    if j + 1 < M:
        nxt = matrix[i][j+1]
        if pipe_mappings[curr][EAST] and pipe_mappings[nxt][WEST]:
            neighbors.append((i, j+1))

    # South
    if i + 1 < N:
        nxt = matrix[i+1][j]
        if pipe_mappings[curr][SOUTH] and pipe_mappings[nxt][NORTH]:
            neighbors.append((i+1, j))

    # West
    if j - 1 >= 0:
        nxt = matrix[i][j-1]
        if pipe_mappings[curr][WEST] and pipe_mappings[nxt][EAST]:
            neighbors.append((i, j-1))

    return neighbors

src = None
for i in range(N):
    for j in range(M):
        if graph[i][j] == 'S':
            src = (i, j)
            break

seen = set([src])
queue = [src]
dists = [[0] * M for _ in range(N)]
while queue:
    elt = queue.pop(0)
    for n in neighbors4(graph, elt[0], elt[1]):
        if n not in seen:
            seen.add(n)
            queue.append(n)
            dists[n[0]][n[1]] = dists[elt[0]][elt[1]] + 1

print(max(map(max, dists)))
