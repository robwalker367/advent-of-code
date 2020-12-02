class PasswordPhilosophy
  def initialize(file_name)
    @lines = File.open(file_name).read.split("\n")
    @processed_lines = process_lines
  end

  def part_one_answer
    valid_password_count = 0
    @processed_lines.each do |line|
      lower = line[0][0]
      upper = line[0][1]
      character = line[1]
      password = line[2]

      char_count = password.count(character)
      if char_count >= lower && char_count <= upper
        valid_password_count += 1
      end
    end
    valid_password_count
  end

  def part_two_answer
    valid_password_count = 0
    @processed_lines.each do |line|
      if only_one_position_in_pwd_has_char?(line)
        valid_password_count += 1
      end
    end
    valid_password_count
  end

  private

  def only_one_position_in_pwd_has_char?(line)
    fst = line[0][0] - 1
    snd = line[0][1] - 1
    char = line[1]
    pwd = line[2]
    (pwd[fst] == char && pwd[snd] != char) || (pwd[fst] != char && pwd[snd] == char)
  end

  def process_lines
    @lines.map do |line|
      split_line = line.split(' ')
      split_line[0] = split_line[0].split('-').map(&:to_i)
      split_line[1] = split_line[1].tr(':', '')
      split_line
    end
  end
end

pwd_phil = PasswordPhilosophy.new('input.txt')
puts "Part 1: " + pwd_phil.part_one_answer.to_s
puts "Part 2: " + pwd_phil.part_two_answer.to_s