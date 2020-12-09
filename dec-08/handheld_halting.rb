require 'set'

class HandheldHalting
  def initialize(file_name)
    @file = File.open(file_name).read.split("\n")
    @parsed_file = parsed_file
  end

  def part_one_answer
    infinite_loop_acc_and_pos(@parsed_file).first
  end

  def part_two_answer
    corrected_program_acc
  end

  def corrected_program_acc
    @parsed_file.each_with_index do |line, index|
      next if line[0] == "acc"
      corrected_file = @parsed_file.clone
      corrected_file[index] = toggle_op(line)
      acc, pos = infinite_loop_acc_and_pos(corrected_file)
      return acc if pos.nil?
    end
    raise "could not correct file"
  end

  def infinite_loop_acc_and_pos(file)
    acc = 0
    pos = 0
    visited = Set[]
    while !visited.include?(pos)
      line = file[pos]
      return [acc, nil] if line.nil?
      op, arg = line
      visited.add(pos)
      if op == "acc"
        acc += arg
        pos += 1
      elsif op == "nop"
        pos += 1
      elsif op == "jmp"
        pos += arg
      else
        raise "invalid operation"
      end
    end
    [acc, pos]
  end

  def parsed_file
    @file.map do |line|
      x, y = line.split(" ")
      [x, y.to_i]
    end
  end

  def toggle_op(line)
    [line[0] == "nop" ? "jmp" : "nop", line[1]]
  end
end

hh = HandheldHalting.new("input.txt")
puts "Part 1: " + hh.part_one_answer.to_s
puts "Part 2: " + hh.part_two_answer.to_s
