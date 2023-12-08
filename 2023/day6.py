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

def quad_formula(a, b, c):
    s1 = (-b + math.sqrt(b ** 2 - 4 * a * c)) / (2 * a)
    s2 = (-b - math.sqrt(b ** 2 - 4 * a * c)) / (2 * a)
    return (s1, s2)

# Part 1
print(math.prod([get_ways_to_win(race) for race in races]))

# Part 2
t, d = '', ''
for race in races:
    t += str(race[0])
    d += str(race[1])
t, d = int(t), int(d)

s1, s2 = quad_formula(-1, t, -d)
print(math.floor(s2) - math.ceil(s1) + 1)
