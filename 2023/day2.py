import re
from math import prod

def is_game_possible(game):
    for g_round in game:
        pulls = g_round.lstrip().split(', ')
        for pull in pulls:
            count = int(re.findall(r'\d+', pull)[0])
            if ('red' in pull and count > 12) or ('green' in pull and count > 13) or ('blue' in pull and count > 14):
                return False
    return True

def get_min_cubes(game):
    result = [0, 0, 0]
    for g_round in game:
        pulls = g_round.lstrip().split(', ')
        for pull in pulls:
            count = int(re.findall(r'\d+', pull)[0])
            if 'red' in pull:
                result[0] = max([result[0], count])
            elif 'green' in pull:
                result[1] = max([result[1], count])
            else:
                result[2] = max([result[2], count])
    return result

with open("input.txt") as f:
    contents = f.read()

games = contents.split('\n')
count = 0
for game in games:
    game = game.split(': ')
    game_id = re.findall(r'\d+', game[0])[0]
    game = game[1].split(';')
    count += prod(get_min_cubes(game))
print(count)
