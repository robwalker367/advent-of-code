import helpers

contents = helpers.read_input()
cards = contents.split('\n')
points = 0
for card in cards:
    win_nums, nums = [set([int(x) for x in elt.split()]) for elt in card.split(': ')[1].split(' | ')]
    win_count = len(win_nums.intersection(nums))
    if win_count > 0:
        points += 2 ** (win_count-1)
print(points)

