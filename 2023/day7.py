import helpers
from collections import Counter
from functools import cmp_to_key

hands = [
    (hand.split()[0], int(hand.split()[1]))
    for hand in helpers.read_input().split('\n')
]

def is_five_of_kind(cards):
    return len(Counter(cards).keys()) == 1

def is_four_of_kind(cards):
    counts = Counter(cards)
    for _, count in counts.items():
        if count == 4:
            return True
    return False

def is_full_house(cards):
    c = list(Counter(cards).values())
    if len(c) == 2:
        return (c[0] == 2 and c[1] == 3) or (c[0] == 3 and c[1] == 2)
    return False

def is_three_of_kind(cards):
    if is_full_house(cards):
        return False
    counts = Counter(cards)
    for _, count in counts.items():
        if count == 3:
            return True
    return False

def is_two_pair(cards):
    return Counter(list(Counter(cards).values()))[2] == 2

def is_one_pair(cards):
    if is_full_house(cards) or is_three_of_kind(cards):
        return False
    return Counter(list(Counter(cards).values()))[2] == 1
    
def is_high(cards):
    return len(Counter(cards).keys()) == 5

strengths = [
    (is_five_of_kind, 7),
    (is_four_of_kind, 6),
    (is_full_house, 5),
    (is_three_of_kind, 4),
    (is_two_pair, 3),
    (is_one_pair, 2),
    (is_high, 1)
]

card_values = list(reversed(['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2']))

def compare(x, y):
    xval, yval = None, None
    for f, w in strengths:
        if f(x[0]):
            xval = w
            break
    for f, w in strengths:
        if f(y[0]):
            yval = w
            break
    if xval == yval:
        for i in range(5):
            idx1, idx2 = card_values.index(x[0][i]), card_values.index(y[0][i])
            if idx1 != idx2:
                return idx1 - idx2
    return xval - yval

# Part 1
ranked = sorted(hands, key=cmp_to_key(compare))
N = len(ranked)
print(sum([ranked[i][1] * (i+1) for i in range(N)]))

def is_five_of_kind_j(cards):
    counts = Counter(cards)
    return is_five_of_kind(cards) or (is_four_of_kind(cards) and counts['J'] in [1, 4]) or (
        is_full_house(cards) and (counts['J'] in [2,3])
    )

def is_four_of_kind_j(cards):
    counts = Counter(cards)
    return is_four_of_kind(cards) or (is_three_of_kind(cards) and counts['J'] in [1, 3]) or (
        is_two_pair(cards) and counts['J'] == 2
    )

def is_full_house_j(cards):
    counts = Counter(cards)
    return is_full_house(cards) or (is_three_of_kind(cards) and counts['J'] == 1) or (
        is_two_pair(cards) and counts['J'] in [1, 2]
    ) or (is_one_pair(cards) and counts['J'] == 2 and len(counts.values()) < 3) 

def is_three_of_kind_j(cards):
    return is_three_of_kind(cards) or (is_one_pair(cards) and 'J' in cards)

def is_two_pair_j(cards):
    return is_two_pair(cards) or (is_one_pair(cards) and 'J' in cards)

def is_one_pair_j(cards):
    return is_one_pair(cards) or 'J' in cards

strengths = [
    (is_five_of_kind_j, 7),
    (is_four_of_kind_j, 6),
    (is_full_house_j, 5),
    (is_three_of_kind_j, 4),
    (is_two_pair_j, 3),
    (is_one_pair_j, 2),
    (is_high, 1)
]

card_values = list(reversed(['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2', 'J']))

def compare(x, y):
    xval, yval = None, None
    for f, w in strengths:
        if f(x[0]):
            xval = w
            break
    for f, w in strengths:
        if f(y[0]):
            yval = w
            break
    if xval == yval:
        for i in range(5):
            idx1, idx2 = card_values.index(x[0][i]), card_values.index(y[0][i])
            if idx1 != idx2:
                return idx1 - idx2
    return xval - yval

# Part 2
ranked = sorted(hands, key=cmp_to_key(compare))
N = len(ranked)
print(sum([ranked[i][1] * (i+1) for i in range(N)]))
