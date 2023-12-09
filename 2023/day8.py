import helpers
from math import lcm

input = helpers.read_input()

instructions = input.split('\n')[0]

network = {}
for elt in input.split('\n\n')[1].split('\n'):
    network[elt[0:3]] = {
        'L': elt[7:10],
        'R': elt[12:15]
    }

def get_steps(node, is_end):
    steps, N = 0, len(instructions)
    while not is_end(node):
        node = network[node][instructions[steps % N]]
        steps += 1
    return steps

# Part 1
print(get_steps('AAA', lambda n : n == 'ZZZ'))

# Part 2
nodes = [node for node in filter(lambda n : n[2] == 'A', network.keys())]
print(lcm(*[get_steps(node, lambda n : n[2] == 'Z') for node in nodes]))
