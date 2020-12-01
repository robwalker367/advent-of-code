require 'set'

class ReportRepairer
  def initialize(file_name, target = 2020)
    @nums = File.read(file_name).split.map(&:to_i)
    @target = target
  end

  def part_one_answer
    find_two_sum&.reduce(&:*)
  end

  def part_two_answer
    find_three_sum&.reduce(&:*)
  end

  private

  def find_two_sum(nums = @nums, target = @target)
    checked_nums = Set.new
    solution = nil
    nums.each do |num|
      if checked_nums.include?(target - num)
        solution = [num, target - num]
        break
      else
        checked_nums.add(num)
      end
    end
    solution
  end

  def find_three_sum
    solution = nil
    @nums.each_with_index do |num, index|
      two_sum_solution = find_two_sum(@nums[index+1..], @target - num)
      if two_sum_solution
        solution = [num, *two_sum_solution]
        break
      end
    end
    solution
  end
end

repairer = ReportRepairer.new('input.txt')
puts "Part 1: " + repairer.part_one_answer.to_s
puts "Part 2: " + repairer.part_two_answer.to_s
