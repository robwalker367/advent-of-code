#include <iostream>
#include <string>
#include <vector>

struct command {
  std::string direction;
  int weight;
};

int main() {
  std::vector<command*> commands;
  std::string s;
  int w;
  while (std::cin >> s >> w) {
    command* c = new command;
    c->direction = s;
    c->weight = w;
    commands.push_back(c);
  }

  int x = 0, depth = 0;
  for (unsigned i = 0, n = commands.size(); i < n; ++i) {
    command* c = commands[i];
    if (c->direction == "forward") {
      x += c->weight;
    } else if (c->direction == "down") {
      depth += c->weight;
    } else {
      depth -= c->weight;
    }
  }
  std::cout << "Part 1: " << x * depth << std::endl;

  for (unsigned i = 0, n = commands.size(); i < n; ++i) {
    delete commands[i];
  }
}

