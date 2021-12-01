#include <vector>
#include <string>
#include <fstream>
#include <iostream>

const int window_size = 3;

int main(void) {
  std::ifstream input("input.txt");
  std::string sbuf;
  std::vector<std::string> v;
  while (getline(input, sbuf)) {
    v.push_back(sbuf);
  }

  int incr = 0;
  int prev_depth = INT32_MAX;
  for (unsigned long i = 0; i < v.size(); ++i) {
    int depth = std::stoi(v[i]);
    if (depth > prev_depth) {
      ++incr;
    }
    prev_depth = depth;
  }
  std::cout << "Part 1: " << incr << std::endl;

  int incr_p2 = 0;
  int prev_sum = INT32_MAX;
  for (unsigned long i = 0; i < v.size() - window_size + 1; ++i) {
    int sum = 0;
    for (unsigned long j = i; j < i + window_size; ++j) {
      sum += std::stoi(v[j]);
    }

    if (sum > prev_sum) {
      ++incr_p2;
    }
    prev_sum = sum;
  }
  std::cout << "Part 2: " << incr_p2 << std::endl;
}

