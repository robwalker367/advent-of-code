#include <iostream>
#include <string>
#include <vector>
#include <cmath>
#include <map>


// entry
//   Struct for representing an entry.

struct entry {
  std::vector<std::string> signals;
  std::vector<std::string> outputs;
  std::map<std::string, int> encodings;

  bool exists_encoding(std::string s) {
    return this->encodings[s] != 0;
  }

  void set_encoding(std::string s, int x) {
    this->encodings[s] = x + 1;
  }

  std::string get_encoding(int x) {
    for (auto& sig : this->signals) {
      if (this->encodings[sig] == x + 1) {
        return sig;
      }
    }
    return "";
  }
};


// Function prototypes

void calculate_encodings(std::vector<entry*>* entries);
int dist(std::string a, std::string b);
bool is_anagram(std::string a, std::string b);


// main()
//   Solves day8 for advent of code 2021.

int main() {
  // Parse input
  std::string s;
  std::vector<entry*> entries;
  entry* e_ = nullptr;
  int i = 0;
  while (std::cin >> s) {
    if (i % 15 == 0) {
      entry* new_e = new entry;
      if (e_) {
        entries.push_back(e_);
      }
      e_ = new_e;
      e_->signals.push_back(s);
    } else if (i % 15 < 10) {
      e_->signals.push_back(s);
    } else if (i % 15 > 10) {
      e_->outputs.push_back(s);
    }
    ++i;
  }
  entries.push_back(e_);

  // Calculate number of 1, 4, 7, and 8's in outputs
  int p1 = 0;
  for (auto& e : entries) {
    for (auto& out : e->outputs) {
      int l = out.length();
      if (l == 2 || l == 3 || l == 4 || l == 7) {
        ++p1;
      }
    }
  }
  std::cout << "P1: " << p1 << std::endl;

  calculate_encodings(&entries);

  // Calculate sum of outputs
  int p2 = 0;
  for (auto& e : entries) {
    int current = 0;
    for (auto& output : e->outputs) {
      for (auto& [key, val] : e->encodings) {
        if (is_anagram(key, output)) {
          current = current * 10 + val - 1;
        }
      }
    }
    p2 += current;
  }
  std::cout << "P2: " << p2 << std::endl;
}


// calculate_encodings(entries)
//   Unscramble the encodings for each entry in `entries`.

void calculate_encodings(std::vector<entry*>* entries) {
  for (auto& e : *entries) {
    // Find encoding for 1, 4, 7, 8
    for (auto& sig : e->signals) {
      int l = sig.length();
      if (l == 2) {
        e->set_encoding(sig, 1);
      } else if (l == 3) {
        e->set_encoding(sig, 7);
      } else if (l == 4) {
        e->set_encoding(sig, 4);
      } else if (l == 7) {
        e->set_encoding(sig, 8);
      }
    }

    // Find encoding for 0
    for (auto& sig : e->signals) {
      if (sig.length() == 6
          && dist(e->get_encoding(8), sig) == 1
          && dist(e->get_encoding(1), sig) == 0
          && dist(e->get_encoding(4), sig) == 1) {
        e->set_encoding(sig, 0);
      }
    }

    // Find encodings for 6 and 9
    for (auto& sig : e->signals) {
      if (e->exists_encoding(sig)) {
        continue;
      }
      if (sig.length() == 6
          && dist(e->get_encoding(4), sig) == 0) {
        e->set_encoding(sig, 9);
      } else if (sig.length() == 6
         && dist(e->get_encoding(4), sig) == 1) {
        e->set_encoding(sig, 6);
      }
    }

    // Find encoding for 3
    for (auto& sig : e->signals) {
      if (e->exists_encoding(sig)) {
        continue;
      }

      if (sig.length() == 5
          && dist(e->get_encoding(1), sig) == 0) {
        e->set_encoding(sig, 3);
      }
    }

    // Find encoding for 2 and 5
    for (auto& sig : e->signals) {
      if (e->exists_encoding(sig)) {
        continue;
      }

      if (sig.length() == 5
          && dist(e->get_encoding(6), sig) == 2) {
        e->set_encoding(sig, 2);
      } else if (sig.length() == 5
          && dist(e->get_encoding(6), sig) == 1) {
        e->set_encoding(sig, 5);
      }
    }
  }
}


// is_anagram(a, b)
//   Determine if `a` and `b` are anagrams.

bool is_anagram(std::string a, std::string b) {
  if (a.length() != b.length()) {
    return false;
  }
  int ak[26] = { 0 };
  int bk[26] = { 0 };
  for (unsigned i = 0; i < a.length(); ++i) {
    ++ak[a[i] - 'a'];
    ++bk[b[i] - 'a'];
  }
  for (unsigned i = 0; i < 26; ++i) {
    if (ak[i] != bk[i]) {
      return false;
    }
  }
  return true;
}


// edit_distance(a, b)
//   Calculate the number of characters in `a` that
//   are not in `b`.

int dist(std::string a, std::string b) {
  int dist = 0;
  for (unsigned i = 0; i < a.size(); ++i) {
    int found = false;
    for (unsigned j = 0; j < b.size(); ++j) {
      if (a[i] == b[j]) {
        found = true;
        continue;
      }
    }
    if (!found) {
      ++dist;
    }
  }
  return dist;
}

