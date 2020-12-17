# TODO: refactor all of this! But alas, I am tired, and must sleep
class TicketTranslation
  attr_accessor :file_sections, :my_ticket
  def initialize(file_name)
    @file_sections = File.open(file_name).read.split("\n\n")
    @my_ticket = ticket_from_line(@file_sections[1].split("\n")[1])
    @nearby_tickets = @file_sections[2].split("\n")[1..].map do |line|
      ticket_from_line(line)
    end
  end

  def part_one_answer
    @nearby_tickets.reduce(0) do |sum, ticket|
      sum + invalid_values_in_ticket(ticket).sum
    end
  end

  def part_two_answer
    solution = Hash.new
    i = 1
    @valid_rules_for_fields_copy = valid_rules_for_fields.clone
    while i < valid_tickets[0].size+1
      position, field_name = @valid_rules_for_fields_copy.find do |position, fields|
        fields.size == 1
      end
      solution[position] = field_name[0]
      valid_rules_for_fields.each do |x, fields|
        @valid_rules_for_fields_copy[x] = @valid_rules_for_fields_copy[x].reject { |m| m == field_name[0] }
      end
      i += 1
    end
    solution.reduce(1) do |prod, elt|
      key, val = elt
      val.start_with?("departure") ? prod * @my_ticket[key] : prod
    end
  end

  def valid_rules_for_fields
    @valid_rules_for_fields ||= begin
      hash = Hash.new(Array.new)
      n = valid_tickets[0].size-1
      (0..n).each do |i|
        rules.each do |rule|
          is_invalid = valid_tickets.any? do |t|
            value_is_invalid_for_rule?(t[i], rule)
          end
          if !is_invalid
            hash[i] += [rule[0]]
          end
        end
      end
      hash
    end
  end

  Range = Struct.new(:low, :high)

  def valid_tickets
    @valid_tickets ||= @nearby_tickets.select do |ticket|
      ticket.all? { |value| valid_value?(value) }
    end
  end

  def invalid_values_in_ticket(ticket)
    ticket.select { |value| invalid_value?(value) }
  end

  def valid_value?(value)
    !invalid_value?(value)
  end

  def invalid_value?(value)
    rules.all? { |rule| value_is_invalid_for_rule?(value, rule) }
  end

  def value_is_invalid_for_rule?(value, rule)
    range1, range2 = rule[1]
    !value.between?(range1.low, range1.high) && !value.between?(range2.low, range2.high)
  end
  
  def rules
    @rules ||= begin
      hash = Hash.new
      file_sections[0].split("\n").each do |rule_line|
        field_name, ranges = rule_line.split(": ")
        range1, range2 = ranges.split(" or ").map { |r| r.split('-').map(&:to_i) }
        hash[field_name] = [
          Range.new(range1[0], range1[1]),
          Range.new(range2[0], range2[1])
        ]
      end
      hash
    end
  end

  def ticket_from_line(line)
    line.split(',').map(&:to_i)
  end
end

tt = TicketTranslation.new('input.txt')
puts "Part 1: " + tt.part_one_answer.to_s
puts "Part 2: " + tt.part_two_answer.to_s