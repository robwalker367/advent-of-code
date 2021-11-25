require 'set'

class EncodingError
  def initialize(file_name)
    @file = File.open(file_name).read.split("\n").map(&:to_i)
    @preamble_length = 25
  end

  def part_one_answer
    @invalid_num ||= invalid_num
  end

  def part_two_answer
    encryption_weakness
  end

  private

  def encryption_weakness
    l, r = 0, 1
    while r < @file.size
      subarray = @file[l..r]
      if subarray.sum == part_one_answer
        return subarray.min + subarray.max
      elsif subarray.sum < part_one_answer
        r += 1
      elsif subarray.sum > part_one_answer
        r += 1 if l == r - 1
        l += 1
      end
    end
    raise "no weakness exists"
  end

  def invalid_num
    (0..@file.size-@preamble_length-1).each do |i|
      preamble = @file[i..i+@preamble_length-1]
      next_num = @file[i+@preamble_length]
      return next_num if two_sum(preamble, next_num) == -1
    end
    raise "invalid num does not exist"
  end

  def two_sum(nums, target)
    visited = Set[]
    nums.each do |num|
      return [num, target-num] if visited.include?(num)
      visited.add(target-num)
    end
    -1
  end
end

ee = EncodingError.new('input.txt')
puts "Part 1: " + ee.part_one_answer.to_s
puts "Part 2: " + ee.part_two_answer.to_s
