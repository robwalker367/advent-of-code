#include <iostream>
#include <string>
#include <vector>

enum direction {
  forward,
  down,
  up
};

struct command {
  direction dir;
  int weight;
};

int main() {
  std::vector<command*> commands;
  std::string s;
  int w;
  while (std::cin >> s >> w) {
    command* c = new command;
    if (s == "forward") {
      c->dir = forward;
    } else if (s == "down") {
      c->dir = down;
    } else {
      c->dir = up;
    }
    c->weight = w;
    commands.push_back(c);
  }

  int x = 0, depth = 0, aim = 0;
  for (unsigned i = 0, n = commands.size(); i < n; ++i) {
    command* c = commands[i];
    if (c->dir == forward) {
      x += c->weight;
      depth += aim * c->weight;
    } else if (c->dir == down) {
      aim += c->weight;
    } else {
      aim -= c->weight;
    }
  }
  std::cout << "Part 1: " << x * depth << std::endl;

  for (unsigned i = 0, n = commands.size(); i < n; ++i) {
    delete commands[i];
  }
}

