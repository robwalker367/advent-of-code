import helpers

hists = [
    list(map(int, line.split()))
    for line in helpers.read_input().split('\n')
]

def get_difference(hist):
    return [hist[i+1] - hist[i] for i in range(len(hist) - 1)]

def extrapolate(hists, set_num):
    k = 0
    for hist in hists:
        diffs = [hist]
        while any(map(lambda x : x != 0, diffs[-1])):
            diffs.append(get_difference(diffs[-1]))
        num = 0
        for diff in reversed(diffs):
            num = set_num(diff, num)
        k += num
    return k

# Part 1
print(extrapolate(hists, lambda d, n : d[-1] + n))

# Part 2
print(extrapolate(hists, lambda d, n : d[0] - n))
