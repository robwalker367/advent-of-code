#include <vector>
#include <iostream>

#define LENGTH 12

int main() {
  long frequencies[LENGTH] = { 0 };
  long num;
  int count = 0;
  while (std::cin >> num) {
    for (unsigned i = 0; i < LENGTH; ++i) {
      frequencies[i] += num % 10;
      num /= 10;
    }
    ++count;
  }

  long gamma = 0, epsilon = 0;
  for (unsigned i = 0; i < LENGTH; ++i) {
    gamma <<= 1;
    epsilon <<= 1;
    if (count - frequencies[LENGTH - i - 1] > count / 2) {
      ++gamma;
    } else {
      ++epsilon;
    }
  }

  std::cout << "Part 1: " << gamma * epsilon << std::endl;
}

