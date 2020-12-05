require 'set'

class BinaryBoarding
  def initialize(file_name)
    @file = File.open(file_name).read.split
  end

  def part_one_answer
    filled_seat_ids.max
  end

  def part_two_answer
    calculate_seat_id(my_seat)
  end

  private

  def my_seat
    possible_seats = (0..127).to_a.product((0..7).to_a).to_set
    unfilled_seats = possible_seats.difference(filled_seats)

    unfilled_seats.find do |seat|
      seat_id = calculate_seat_id(seat)
      filled_seat_ids.include?(seat_id - 1) && filled_seat_ids.include?(seat_id + 1)
    end
  end

  def filled_seats
    @filled_seats ||= (@file.map do |line|
      [find_row(line[0..6]), find_col(line[7..])]
    end).to_set
  end

  def filled_seat_ids
    @filled_seat_ids ||= (filled_seats.map do |seat|
      calculate_seat_id(seat)
    end).to_set
  end

  def calculate_seat_id(seat)
    seat[0] * 8 + seat[1]
  end

  def find_row(str)
    bin_search(str, 127, "F", "B")
  end

  def find_col(str)
    bin_search(str, 7, "L", "R")
  end

  def bin_search(str, max, zero, one)
    lower, upper = 0, max
    str.split("").each do |letter|
      if letter == zero
        upper -= (upper - lower + 1) / 2
      elsif letter == one
        lower += (upper - lower + 1) / 2
      end
    end
    raise "bin_search error" unless lower == upper
    lower
  end
end

bb = BinaryBoarding.new('input.txt')
puts "Part 1: " + bb.part_one_answer.to_s
puts "Part 2: " + bb.part_two_answer.to_s