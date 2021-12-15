#include <iostream>
#include <vector>
#include <cstdlib>


// Function prototypes

std::vector<int> split(std::string s, char delimiter);


// bingo_cell
//   Struct for storing a bingo cell.

struct bingo_cell {
  int num;
  bool drawn = false;
};


// bingo_board
//   Struct for storing a bingo board.

struct bingo_board {
  int width = 5;
  int height = 5;
  std::vector<bingo_cell*> cells;
  bool completed = false;

  bingo_cell* cell(int x, int y) {
    return cells[x * height + y];
  }

  void mark_num(int x) {
    for (auto& cell : cells) {
      if (cell->num == x) {
        cell->drawn = true;
      }
    }
  }

  // Determine if board has winning position.
  // Currently only works for square boards.
  bool won() {
    for (int i = 0; i < this->width; ++i) {
      bool row_all_drawn = true;
      bool col_all_drawn = true;
      for (int j = 0; j < this->height; ++j) {
        if (!this->cell(i, j)->drawn) {
          row_all_drawn = false;
        }
        if (!this->cell(j, i)->drawn) {
          col_all_drawn = false;
        }
      }
      if (col_all_drawn || row_all_drawn) {
        return true;
      }
    }
    return false;
  }

  int sum_undrawn() {
    int sum = 0;
    for (auto& cell : cells) {
      if (!cell->drawn) {
        sum += cell->num;
      }
    }
    return sum;
  }

  void print_board() {
    for (int i = 0; i < this->width; ++i) {
      for (int j = 0; j < this->height; ++j) {
        bingo_cell* c = this->cell(i, j);
        if (c->drawn) {
          std::cout << "\033[1m";
        }
        std::cout << this->cell(i, j)->num << " ";
        if (c->drawn) {
          std::cout << "\033[0m";
        }
      }
      std::cout << std::endl;
    }
    std::cout << std::endl;
  }
};


// main
//   Solves day4 for advent of code 2021.

int main() {
  // Parse drawn numbers
  std::string s;
  std::cin >> s;
  std::vector<int> nums = split(s, ',');

  // Parse boards
  std::vector<bingo_board*> boards;
  bingo_board* b = nullptr;
  std::string line;
  while (std::getline(std::cin, line)) {
    if (line == "") {
      if (b) {
        boards.push_back(b);
        b = nullptr;
      }
      continue;
    }
    if (!b) {
      b = new bingo_board;
    }
    std::vector<int> row = split(line, ' ');
    for (auto& x : row) {
      bingo_cell* bc = new bingo_cell;
      bc->num = x;
      b->cells.push_back(bc);
    }
  }

  // Draw numbers
  unsigned long completed_boards = 0;
  for (auto& num : nums) {
    // Mark number on boards
    for (auto& board : boards) {
      board->mark_num(num);
    }

    // Calculate scores
    for (auto& board : boards) {
      if (!board->completed && board->won()) {
        board->completed = true;
        if (completed_boards == 0) {
          std::cout << "P1 score: " << board->sum_undrawn() * num << std::endl;
        }
        if (++completed_boards == boards.size()) {
          std::cout << "P2 score: " << board->sum_undrawn() * num << std::endl;
          break;
        }
      }
    }

    // Stop iterating if all boards completed
    if (completed_boards == boards.size()) {
      break;
    }
  }

  // Free memory
  for (auto& board : boards) {
    for (auto& cell : board->cells) {
      delete cell;
    }
    delete board;
  }
}


// split(s, delimiter)
//   Splits a string s based on the delimiter.

std::vector<int> split(std::string s, char delimiter) {
  std::vector<int> nums;
  int current = 0;
  bool tracking = false;
  for (unsigned i = 0, n = s.length(); i < n; ++i) {
    if (s[i] != delimiter) {
      tracking = true;
      current = current * 10 + std::atoi(s.substr(i, 1).c_str());
    } else {
      if (tracking) {
        nums.push_back(current);
        tracking = false;
      }
      current = 0;
    }
  }
  if (s[s.length() - 1] != delimiter) {
    nums.push_back(current);
  }
  return nums;
}
