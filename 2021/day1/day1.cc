#include <vector>
#include <string>
#include <fstream>
#include <iostream>

const int window_size = 3;

int main(void) {
  std::ifstream input("input.txt");
  std::string s;
  std::vector<int> v;
  while (getline(input, s)) {
    v.push_back(std::stoi(s));
  }

  int p1 = 0;
  int prev_depth = INT32_MAX;
  for (unsigned long i = 0; i < v.size(); ++i) {
    if (v[i] > prev_depth) {
      ++p1;
    }
    prev_depth = v[i];
  }
  std::cout << "Part 1: " << p1 << std::endl;

  int p2 = 0;
  int prev_sum = INT32_MAX;
  for (unsigned long i = 0; i <= v.size() - window_size; ++i) {
    int sum = 0;
    for (unsigned long j = i; j < i + window_size; ++j) {
      sum += v[j];
    }

    if (sum > prev_sum) {
      ++p2;
    }
    prev_sum = sum;
  }
  std::cout << "Part 2: " << p2 << std::endl;
}

