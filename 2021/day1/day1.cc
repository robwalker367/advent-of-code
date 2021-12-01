#include <vector>
#include <string>
#include <fstream>
#include <iostream>

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
  std::cout << incr << std::endl;
}

