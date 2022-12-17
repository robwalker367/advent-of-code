# AoC 2022 Day 1

with open("input.txt") as file:
  lines = [line.rstrip() for line in file]
  
elf_cals = []

cals = 0
for line in lines:
  if line != "":
    cals += int(line)
  else:
    elf_cals.append(cals)
    cals = 0

# Part 1
print(max(elf_cals))

# Part 2
elf_cals = sorted(elf_cals)
print(sum(elf_cals[-3:]))
