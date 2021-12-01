#include <vector>
#include <string>
#include <iostream>

const int window_size = 3;

int main(void) {
  std::string s;
  std::vector<int> v;
  while (std::cin >> s) {
    v.push_back(std::stoi(s));
  }

  int p1 = 0;
  for (unsigned i = 0, n = v.size() - 1; i < n; ++i) {
    p1 += v[i] < v[i + 1];
  }
  std::cout << "Part 1: " << p1 << std::endl;

  int p2 = 0;
  for (unsigned i = 0, n = v.size() - window_size; i < n; ++i) {
    p2 += v[i] < v[i + window_size];
  }
  std::cout << "Part 2: " << p2 << std::endl;
}

