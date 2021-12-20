#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <cmath>
#include <numeric>


// Function prototypes

std::vector<int> read_crabs(std::string s, char delimiter);
int fuel_consumption(std::vector<int>* crabs, int value);


// main()
//   Solves advent of code day7.

int main() {
  // Parse input
  std::string s;
  std::cin >> s;
  std::vector<int> crabs = read_crabs(s, ',');

  // Calculate fuel for part one
  std::sort(crabs.begin(), crabs.end());
  int median_crab = crabs[crabs.size() / 2];
  int p1_fuel = 0;
  for (auto& crab : crabs) {
    p1_fuel += std::abs(median_crab - crab);
  }
  std::cout << "P1: " << p1_fuel << std::endl;

  // Calculate fuel for part two
  float mean = std::accumulate(crabs.begin(), crabs.end(), 0.0) / crabs.size();
  int fuel_ceil = fuel_consumption(&crabs, std::ceil(mean));
  int fuel_floor = fuel_consumption(&crabs, std::floor(mean));
  std::cout << "P2: " << std::min(fuel_ceil, fuel_floor) << std::endl;
}


// fuel_consumption(crabs, value)
//   Calculates the fuel consumption required for crabs in
//   `crabs` to move to `value` with weights.

int fuel_consumption(std::vector<int>* crabs, int value) {
  int fuel = 0;
  for (auto& crab : *crabs) {
    int n = std::abs(value - crab);
    fuel += (n * (n + 1)) / 2;
  }
  return fuel;
}


// read_crabs(s, delimiter)
//   Reads horizontal position of crabs in `s` using
//   `delimiter`.

std::vector<int> read_crabs(std::string s, char delimiter) {
  std::vector<int> crabs;
  unsigned i = 0, j = 0, n = s.size();
  while (j <= n) {
    if ((s[j] == delimiter || j == n) && i != j) {
      crabs.push_back(std::atoi(s.substr(i, j - i).c_str()));
      ++j;
      i = j;
    } else {
      ++j;
    }
  }
  return crabs;
}

