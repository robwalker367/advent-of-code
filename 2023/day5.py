import helpers

input = helpers.read_input()

seeds = [
    int(seed) 
    for seed in input
        .split('\n')[0][7:]
        .split()
]

almanac_maps = [
    almanac_map.split('\n')[1:]
    for almanac_map in input.split('\n\n')[1:]
]

def get_mapped_num(num, amap):
    for r in amap:
        src, dst, rng = [int(x) for x in r.split()]
        if src <= num and num < src + rng:
            return dst + (num - src)
    return num

def get_seed_num(loc_num, almanac_maps):
    num = loc_num
    for amap in almanac_maps:
        num = get_mapped_num(num, amap)
    return num

# Part 2
def is_within_seed_range(seeds, seed):
    for i in range(0, len(seeds), 2):
        src, rng = seeds[i], seeds[i+1]
        if src <= seed and seed < src + rng:
            return True
    return False

loc_num = 0
almanac_maps = list(reversed(almanac_maps))
while True:
    seed = get_seed_num(loc_num, almanac_maps)
    if is_within_seed_range(seeds, seed):
        print(loc_num)
        break
    loc_num += 1
