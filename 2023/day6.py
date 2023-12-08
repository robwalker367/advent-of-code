import helpers
import math

# Read input
races = [
    line.split(':')[1].split()
    for line in helpers.read_input().split('\n')
]
races = [
    (int(race[0]), int(race[1]))
    for race in zip(races[0], races[1])
]

def get_ways_to_win(race):
    return sum([(race[0] - hold) * hold > race[1] for hold in range(race[0])])

# Part 1
print(math.prod([get_ways_to_win(race) for race in races]))
