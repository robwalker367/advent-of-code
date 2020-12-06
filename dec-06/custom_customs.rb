require 'set'

class CustomCustoms
  def initialize(file_name)
    @file = File.open(file_name).read.split("\n\n")
  end

  def part_one_answer
    count_yes_answers(any_yes_answers)
  end

  def part_two_answer
    count_yes_answers(all_yes_answers)
  end

  private

  def any_yes_answers
    @file.map do |group|
      yes_answers = Set[]
      group.split("\n").each do |person|
        yes_answers = yes_answers.union(person.split("").to_set)
      end
      yes_answers
    end
  end

  def all_yes_answers
    @file.map do |group|
      yes_answers = ('a'..'z').to_set
      group.split("\n").each do |person|
        yes_answers = yes_answers.intersection(person.split("").to_set)
      end
      yes_answers
    end
  end

  def count_yes_answers(lst)
    lst.reduce(0) { |sum, set| sum + set.size }
  end
end

cc = CustomCustoms.new("input.txt")
puts "Part 1: " + cc.part_one_answer.to_s
puts "Part 2: " + cc.part_two_answer.to_s