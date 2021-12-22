#include <iostream>
#include <string>
#include <vector>
#include <map>


// cell
//   Struct for storing a cell

struct cell {
  int val = 0;
  int basin = -1;
  bool explored = false;

  bool in_basin() {
    return this->basin != -1;
  }
};


// heightmap
//   Struct for storing a heightmap

struct heightmap {
  int width = 0;
  int height = 0;
  std::vector<cell*> cells;
  cell* obstacle = nullptr;
  int total_basins = 0;

  heightmap() {
    obstacle = new struct cell;
    obstacle->explored = true;
    obstacle->val = INT_MAX;
  }

  ~heightmap() {
    delete this->obstacle;
    for (auto& cell : this->cells) {
      delete cell;
    }
  }

  cell* cell(int x, int y) {
    if (0 <= x && x < this->height && 0 <= y && y < this->width) {
      return this->cells[x * width + y];
    } else {
      return this->obstacle;
    }
  }

  void print_board() {
    for (int i = 0; i < this->height; ++i) {
      for (int j = 0; j < this->width; ++j) {
        std::cout << this->cell(i, j)->val;
      }
      std::cout << std::endl;
    }
  }

  void print_basins() {
    for (int i = 0; i < this->height; ++i) {
      for (int j = 0; j < this->width; ++j) {
        struct cell* c = this->cell(i, j);
        std::cout << (c->basin >= 0 ? c->basin : 0);
      }
      std::cout << std::endl;
    }
  }
};


// Function prototypes

void calculate_basins(heightmap* h);
void explore(heightmap* h, int x, int y);
int max_basin(std::map<int, int>* m);


// main()
//   Solves day9 for advent of code 2021.

int main() {
  // Parse input
  std::string s;
  heightmap* h = new heightmap;
  while (std::cin >> s) {
    h->width = s.length();
    for (auto& c : s) {
      cell* cl = new cell;
      cl->val = (int)(c - '0');
      h->cells.push_back(cl);
    }
  }
  h->height = h->cells.size() / h->width;

  // Count number of lowest cells
  int p1 = 0;
  for (int i = 0; i < h->height; ++i) {
    for (int j = 0; j < h->width; ++j) {
      int c = h->cell(i, j)->val;
      if (c < h->cell(i - 1, j)->val
          && c < h->cell(i, j - 1)->val
          && c < h->cell(i, j + 1)->val
          && c < h->cell(i + 1, j)->val) {
        p1 += 1 + c;
      }
    }
  }
  std::cout << "P1: " << p1 << std::endl;

  // Find basins
  calculate_basins(h);

  // Sum basins
  std::map<int, int> basin_sums;
  for (auto& c : h->cells) {
    if (c->in_basin()) {
      ++basin_sums[c->basin];
    }
  }

  // Find top three basins
  int m1 = max_basin(&basin_sums);
  int m2 = max_basin(&basin_sums);
  int m3 = max_basin(&basin_sums);
  int p2 = m1 * m2 * m3;
  std::cout << "P2: " << p2 << std::endl;

  // Free memory
  delete h;
}


// max_basin(m)
//   Find the maximum basin in `m`.

int max_basin(std::map<int, int>* m) {
  int max_key = -1;
  for (auto& [key, val] : *m) {
    if (val > (*m)[max_key]) {
      max_key = key;
    }
  }
  int max = (*m)[max_key];
  (*m)[max_key] = -1;
  return max;
}


// calculate_basins(h)
//   Calculate the basins in `h`.

void calculate_basins(heightmap* h) {
  for (int i = 0; i < h->height; ++i) {
    for (int j = 0; j < h->width; ++j) {
      explore(h, i, j);
    }
  }
}


// explore(h, x, y)
//   Explore the heightmap starting from the
//   cell at `x` and `y`. Add cell to basin
//   or create new basin if appropriate.

void explore(heightmap* h, int x, int y) {
  // Get cell
  cell* c = h->cell(x, y);

  // Return if explored or not possibly a basin
  if (c->explored || 9 <= c->val) {
    c->explored = true;
    return;
  }

  // Mark cell as explored
  c->explored = true;

  // Add cell to basin of adjacent cells
  cell* adj_cells[4] = {
    h->cell(x - 1, y),
    h->cell(x, y - 1),
    h->cell(x, y + 1),
    h->cell(x + 1, y)
  };
  for (int i = 0; i < 4; ++i) {
    cell* adj = adj_cells[i];
    if (adj->explored && adj->in_basin()) {
      c->basin = adj->basin;
    }
  }

  // Start new basin if cell is not adjacent to any basins
  if (!c->in_basin()) {
    ++h->total_basins;
    c->basin = h->total_basins;
  }

  // Explore adjacent cells
  explore(h, x - 1, y);
  explore(h, x, y - 1);
  explore(h, x, y + 1);
  explore(h, x + 1, y);
}

