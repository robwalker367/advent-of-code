#include <vector>
#include <iostream>
#include <cmath>

#define LENGTH 12

long* count_frequencies(std::vector<long>* v) {
  long* f = new long[LENGTH];
  for (unsigned i = 0; i < LENGTH; ++i) {
    f[i] = 0;
  }
  for (unsigned i = 0; i < v->size(); ++i) {
    long num = (*v)[i];
    for (unsigned j = 0; j < LENGTH; ++j) {
      f[j] += num % 10;
      num /= 10;
    }
  }
  return f;
}

long bin2dec(long b) {
  long output = 0;
  int pos = 1;
  while (b) {
    output += (b % 10) * pos;
    pos *= 2;
    b /= 10;
  }
  return output;
}

int main() {
  long num;
  int count = 0;
  std::vector<long> pow_v, oxy_v, co2_v;
  while (std::cin >> num) {
    pow_v.push_back(num);
    oxy_v.push_back(num);
    co2_v.push_back(num);
    ++count;
  }

  long* pow_f = count_frequencies(&pow_v);
  long gamma = 0, epsilon = 0;
  for (unsigned i = 0; i < LENGTH; ++i) {
    gamma <<= 1;
    epsilon <<= 1;
    if (count - pow_f[LENGTH - i - 1] > count / 2) {
      ++gamma;
    } else {
      ++epsilon;
    }
  }
  delete pow_f;

  std::cout << "Part 1: " << gamma * epsilon << std::endl;

  int pos = LENGTH;
  while (oxy_v.size() > 1) {
    --pos;
    long* f = count_frequencies(&oxy_v);
    int k = oxy_v.size();
    int majority_bit;
    if (k % 2 == 0 && f[pos] == k / 2) {
      majority_bit = 1;
    } else {
      majority_bit = f[pos] > k / 2;
    }
    int i = 0;
    while (--k >= 0) {
      long divisor = pow(10.0, (double) pos);
      if ((oxy_v[i] / divisor) % 10 != majority_bit) {
        oxy_v.erase(oxy_v.begin() + i);
      } else {
        ++i;
      }
    }
    delete f;
  }

  pos = LENGTH;
  while (co2_v.size() > 1) {
    --pos;
    long* f = count_frequencies(&co2_v);
    int k = co2_v.size();
    int majority_bit;
    if (k % 2 == 0 && k - f[pos] == k / 2) {
      majority_bit = 0;
    } else {
      majority_bit = k - f[pos] > k / 2;
    }
    int i = 0;
    while (--k >= 0) {
      long divisor = pow(10.0, (double) pos);
      if ((co2_v[i] / divisor) % 10 != majority_bit) {
        co2_v.erase(co2_v.begin() + i);
      } else {
        ++i;
      }
    }
    delete f;
  }
  long oxy = bin2dec(oxy_v[0]);
  long co2 = bin2dec(co2_v[0]);
  std::cout << "Part 2: " << oxy * co2 << std::endl;
}

