#include <iostream>
#include <string>
#include <vector>


// Number of cycles to breed
const int p1_cycles = 80;
const int p2_cycles = 256;


// Total cycle length for a fish

const long long total_cycle = 9;


// Time for a fish to spawn on its first cycle
const long long fst_spawn_cycle = 8;


// Time for a fish to spawn on non-first cycle
const long long std_spawn_cycle = 6;


// Helper function prototypes

long long* read_fish(std::string s);
void breed_fish(long long* fish);
long long sum_fish(long long* fish);


// main()
//   Solves day6 for advent of code 2021

int main() {
  // Parse input
  std::string s;
  std::cin >> s;
  long long* fish = read_fish(s);

  // Breed fish for p1
  for (unsigned i = 0; i < p1_cycles; ++i) {
    breed_fish(fish);
  }
  std::cout << "P1: " << sum_fish(fish) << std::endl;

  // Breed fish for p2
  for (unsigned i = p1_cycles; i < p2_cycles; ++i) {
    breed_fish(fish);
  }
  std::cout << "P2: " << sum_fish(fish) << std::endl;

  // Free memory
  delete fish;
}


// breed_fish(fish)
//   Breed fish in `fish`

void breed_fish(long long* fish) {
  long long new_fish[total_cycle];
  memset(new_fish, 0, total_cycle * sizeof(long long));
  for (long long i = 0; i < total_cycle; ++i) {
    if (i == 0) {
      new_fish[fst_spawn_cycle] += fish[i];
      new_fish[std_spawn_cycle] += fish[i];
    } else {
      new_fish[i - 1] += fish[i];
    }
  }
  memcpy(fish, new_fish, total_cycle * sizeof(long long));
}


// sum_fish(fish)
//   Sum fish in `fish`

long long sum_fish(long long* fish) {
  long long sum = 0;
  for (unsigned i = 0; i < total_cycle; ++i) {
    sum += fish[i];
  }
  return sum;
}


// read_fish(s)
//   Read fish from string `s`

long long* read_fish(std::string s) {
  long long* fish = new long long[total_cycle];
  memset(fish, 0, total_cycle * sizeof(long long));
  int num = 0;
  for (unsigned i = 0, n = s.size(); i < n; ++i) {
    std::string c = s.substr(i, 1);
    if (c == ",") {
      ++fish[num];
      num = 0;
    } else {
      num = num * 10 + std::atoi(c.c_str());
    }
  }
  if (s.substr(s.size() - 1, 1) != ",") {
    ++fish[num];
  }
  return fish;
}

