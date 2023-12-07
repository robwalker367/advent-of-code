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
        dst, src, rng = [int(x) for x in r.split()]
        if src <= num and num < src + rng:
            return dst + (num - src)
    return num

def get_location_num(seed, almanac_maps):
    num = seed
    for amap in almanac_maps:
        num = get_mapped_num(num, amap)
    return num

print(min([get_location_num(seed, almanac_maps) for seed in seeds]))
    