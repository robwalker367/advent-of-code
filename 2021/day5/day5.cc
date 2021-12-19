#include <cstdlib>
#include <cmath>
#include <iostream>
#include <map>
#include <string>
#include <vector>


// node
//   Struct for storing a coordinate in a grid.

struct node {
  int x;
  int y;

  node(int x_, int y_) {
    x = x_;
    y = y_;
  }

  void print() {
    std::cout << x << "," << y << std::endl;;
  }
};


// Helper function prototypes

node* read_node(std::string s);
int count_overlaps(std::map<int, std::map<int, int> >* overlaps, int threshold);


// line
//   Struct for storing a line of clouds from a
//   hydrothermal vent.

struct line {
  node* src;
  node* dst;
  line(node* src_, node* dst_) {
    src = src_;
    dst = dst_;
  }
};


// main()
//   Solves day5 for advent of code 2021.

int main() {
  // Parse input
  std::string a, arrow, b;
  std::vector<line*> lines;
  while (std::cin >> a >> arrow >> b) {
    node* src = read_node(a);
    node* dst = read_node(b);
    line* l = new line(src, dst);
    lines.push_back(l);
  }

  // Count overlaps for part 1
  std::map<int, std::map<int, int> > overlaps;
  for (auto& l : lines) {
    // Only consider horizontal or vertical lines
    if (l->src->x == l->dst->x) {
      for (int i = std::min(l->src->y, l->dst->y),
           n = std::max(l->src->y, l->dst->y);
           i <= n; ++i) {
        ++overlaps[l->src->x][i];
      }
    } else if (l->src->y == l->dst->y) {
      for (int i = std::min(l->src->x, l->dst->x),
           n = std::max(l->src->x, l->dst->x);
           i <= n; ++i)
        ++overlaps[i][l->src->y];
    }
  }
  int p1 = count_overlaps(&overlaps, 2);
  std::cout << "P1: " << p1 << std::endl;

  // Count overlaps for part 2
  for (auto& l : lines) {
    if (l->src->x == l->dst->x || l->src->y == l->dst->y) {
      continue;
    }

    // Order nodes by x value
    bool srcx_lt_dstx = l->src->x <= l->dst->x;
    node* left = srcx_lt_dstx ? l->src : l->dst;
    node* right = srcx_lt_dstx ? l->dst : l->src;

    // Tally overlaps diagonally
    int i = left->x, j = left->y;
    while (i <= right->x) {
      ++overlaps[i][j];
      ++i;
      j += left->y < right->y ? 1 : -1;
    }
  }
  int p2 = count_overlaps(&overlaps, 2);
  std::cout << "P2: " << p2 << std::endl;

  // Free memory
  for (auto& l : lines) {
    delete l->src;
    delete l->dst;
    delete l;
  }
}


// read_node(s)
//   Reads a string of format "x,y" where x and y are
//   integers into a node.

node* read_node(std::string s) {
  int x = 0, y = 0;
  bool left_of_comma = true;
  for (unsigned i = 0, n = s.length(); i < n; ++i) {
    std::string c = s.substr(i, 1);
    if (c == ",") {
      left_of_comma = false;
      continue;
    }
    int num = std::atoi(c.c_str());
    if (left_of_comma) {
      x = x * 10 + num;
    } else {
      y = y * 10 + num;
    }
  }
  node* n = new node(x, y);
  return n;
}


// count_overlaps(overlaps, threshold)
//   Count the number of overlaps that exceed the threshold.

int count_overlaps(std::map<int, std::map<int, int> >* overlaps, int threshold) {
  int k = 0;
  for (auto& [_, m] : *overlaps) {
    for (auto& [_, count] : m) {
      if (count >= threshold) {
        ++k;
      }
    }
  }
  return k;
}

