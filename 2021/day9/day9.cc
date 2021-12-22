#include <iostream>
#include <string>
#include <vector>

struct heightmap {
  int width = 0;
  int height = 0;
  std::vector<int> cells;

  int cell(int x, int y) {
    if (0 <= x && x < this->height && 0 <= y && y < this->width) {
      return this->cells[x * width + y];
    } else {
      return INT_MAX;
    }
  }
};

int main() {
  std::string s;
  heightmap* h = new heightmap;
  while (std::cin >> s) {
    h->width = s.length();
    for (auto& c : s) {
      h->cells.push_back((int)(c - '0'));
    }
  }
  h->height = h->cells.size() / h->width;

  int p1 = 0;
  for (int i = 0; i < h->height; ++i) {
    for (int j = 0; j < h->width; ++j) {
      int c = h->cell(i, j);
      if (c < h->cell(i - 1, j)
          && c < h->cell(i, j - 1)
          && c < h->cell(i, j + 1)
          && c < h->cell(i + 1, j)) {
        p1 += 1 + c;
      }
    }
  }
  std::cout << "P1: " << p1 << std::endl;
}

