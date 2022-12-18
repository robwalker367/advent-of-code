# AoC 2022 Day 2

with open("input.txt") as file:
  lines = [line.rstrip() for line in file]

# Part 1

score_config = {
  "X": 1, # rock
  "Y": 2, # paper
  "Z": 3, # scissors
}

loss_config = {
  "A": "Z", # rock > scissors
  "B": "X", # paper > rock
  "C": "Y", # scissors > paper
}

draw_config = {
  "A": "X",
  "B": "Y",
  "C": "Z",
}

LOSS = 0
DRAW = 3
WIN = 6

score = 0
for line in lines:
  game = line.split(' ')

  if draw_config[game[0]] == game[1]:
    score += DRAW
  elif loss_config[game[0]] == game[1]:
    score += LOSS
  else:
    score += WIN

  score += score_config[game[1]]

print(score)

# Part 2

win_config = {
  "A": "Y",
  "B": "Z",
  "C": "X",
}

score = 0
for line in lines:
  game = line.split(' ')

  if game[1] == 'X':
    play = loss_config[game[0]]
    score += LOSS
  elif game[1] == 'Y':
    play = draw_config[game[0]]
    score += DRAW
  else:
    play = win_config[game[0]]
    score += WIN
  
  score += score_config[play]
  
print(score)
