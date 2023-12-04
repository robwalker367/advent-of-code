import helpers

input = helpers.read_input().split('\n')

cards = []
for line in input:
    cards.append([set([int(x) for x in elt.split()]) for elt in line.split(': ')[1].split(' | ')])

points = 0
copies = [1] * len(cards)
for i in range(len(cards)):
    win_nums, nums = cards[i]
    win_count = len(win_nums.intersection(nums))
    for j in range(i+1, i+1+win_count):
        copies[j] += copies[i]
    if win_count > 0:
        points += 2 ** (win_count-1)

# part 1 answer
print(points)

# part 2 answer
print(sum(copies))
