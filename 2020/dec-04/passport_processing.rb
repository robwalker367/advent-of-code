require 'set'

class PassportProcessing
  def initialize(file_name)
    @file = File.open(file_name).read.split("\n")
    @passports = separate_into_passports
    @passport_key_sets = setify_passport_keys
    @valid_passport_fields = Set['byr','iyr','eyr','hgt','hcl','ecl','pid']
  end

  def part_one_answer
    @passport_key_sets.count { |passport| @valid_passport_fields.subset?(passport) }
  end

  def part_two_answer
    @passports.count do |passport|
      keys = passport.map { |field| field.split(":").first }
      passport.all? { |field| field_is_valid(field) } &&
        @valid_passport_fields.subset?(keys.to_set)
    end
  end

  private

  def field_is_valid(field)
    key, val = field.split(":")
    if key == "byr"
      valid_range?(val, 1920, 2002)
    elsif key == "iyr"
      valid_range?(val, 2010, 2020)
    elsif key == "eyr"
      valid_range?(val, 2020, 2030)
    elsif key == "hgt"
      h = val[0..(val.length-3)]
      u = val[(val.length-2)..]
      if u == "cm"
        int?(h) && valid_range?(h, 150, 193)
      elsif u == "in"
        int?(h) && valid_range?(h, 59, 76)
      else
        false
      end
    elsif key == "hcl"
      val[0] == "#" && alphanum?(val[1..])
    elsif key == "ecl"
      ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(val)
    elsif key == "pid"
      val.length == 9 && int?(val)
    else
      true
    end
  end

  def valid_range?(val, lower, upper)
    int?(val) && val.to_i >= lower && val.to_i <= upper
  end

  def alphanum?(x)
    x[/[0-9a-z]+/i] == x
  end

  def int?(x)
    x[/[0-9]+/i] == x
  end

  def separate_into_passports
    passports = [[]]
    k = 0
    @file.each_with_index do |line, index|
      if line != ""
        passports[k] += line.split(" ")
      else
        k += 1
        passports.append([])
      end
    end
    passports
  end

  def setify_passport_keys
    @passports.map do |passport|
      (passport.map { |field| field.partition(":").first }).to_set
    end
  end

  def setify_passport_values
    @passports.map do |passport|
      (passport.map { |field| field.partition(":").last }).to_set
    end
  end
end

pp = PassportProcessing.new('input.txt')
puts "Part 1: " + pp.part_one_answer.to_s
puts "Part 2: " + pp.part_two_answer.to_s