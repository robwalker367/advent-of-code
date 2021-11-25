require 'set'

class HandyHaversacks
  def initialize(file_name)
    @file = File.open(file_name).read.split("\n")
    @rules = parse_file_into_hash
  end

  def part_one_answer
    find_enclosing_bags("shiny gold").size
  end

  def part_two_answer
    total_bags_inside_color("shiny gold")
  end

  private

  class Rule
    attr_accessor :count, :color
    def initialize(count, color)
      @count = count
      @color = color
    end
  end

  def find_enclosing_bags(color)
    enclosing_bags = Set[]
    @rules.each do |key, val|
      if (rule = val.find { |rule| rule.color == color })
        enclosing_bags.add(key)
        enclosing_bags.merge(find_enclosing_bags(key))
      end
    end
    enclosing_bags
  end

  def total_bags_inside_color(color)
    count_total_bags_for_color_rule(@rules[color]) - 1
  end

  def count_total_bags_for_color_rule(color_rules)
    return 1 if color_rules.nil?
    color_rules.reduce(1) do |sum, rule|
      sum + rule.count * count_total_bags_for_color_rule(@rules[rule.color])
    end
  end

  def parse_file_into_hash
    hash = {}
    @file.each do |line|
      split_line = line.split(" ")
      color = "#{split_line[0]} #{split_line[1]}"
      if !line.include?("no other")
        rules = split_line[(split_line.find_index("contain") + 1)..]
        i, n = 0, rules.size
        while i < n
          k = rules[i]
          color_rule = Rule.new(k.to_i, "#{rules[i+1]} #{rules[i+2]}")
          hash[color] = hash[color] ? hash[color] << color_rule : [color_rule]
          i += 4
        end
      end
    end
    hash
  end
end

hh = HandyHaversacks.new('input.txt')
puts "Part 1: " + hh.part_one_answer.to_s
puts "Part 2: " + hh.part_two_answer.to_s