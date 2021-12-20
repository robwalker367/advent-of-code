#include <iostream>
#include <string>
#include <vector>


// Number of cycles to breed
const int cycles = 80;


// Time for a fish to spawn on its first cycle
const int fst_spawn_cycle = 8;


// Time for a fish to spawn on non-first cycle
const int std_spawn_cycle = 6;


// Helper function prototypes

std::vector<int> read_fish(std::string s);
void breed_fish(std::vector<int>* fish);


// main()
//   Solves day6 for advent of code 2021

int main() {
  // Parse input
  std::string s;
  std::cin >> s;
  std::vector<int> fish = read_fish(s);

  // Breed fish
  for (unsigned i = 0; i < cycles; ++i) {
    breed_fish(&fish);
  }
  std::cout << "P1: " << fish.size() << std::endl;
}


// breed_fish(fish)
//   Breed fish in `fish`

void breed_fish(std::vector<int>* fish) {
  unsigned n = fish->size();
  for (unsigned i = 0; i < n; ++i) {
    if (--(*fish)[i] < 0) {
      (*fish)[i] = std_spawn_cycle;
      fish->push_back(fst_spawn_cycle);
    }
  }
}


// read_fish(s)
//   Read fish from string `s`

std::vector<int> read_fish(std::string s) {
  std::vector<int> fish;
  int num = 0;
  for (unsigned i = 0, n = s.size(); i < n; ++i) {
    std::string c = s.substr(i, 1);
    if (c == ",") {
      fish.push_back(num);
      num = 0;
    } else {
      num = num * 10 + std::atoi(c.c_str());
    }
  }
  if (s.substr(s.size() - 1, 1) != ",") {
    fish.push_back(num);
  }
  return fish;
}

