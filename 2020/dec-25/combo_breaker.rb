class ComboBreaker
  attr_reader :card_public_key, :door_public_key, :divisor
  def initialize
    @card_public_key = 9232416
    @door_public_key = 14144084
    @divisor = 20201227
  end

  def part_one_answer
    encryption_key
  end

  def encryption_key
    raise unless card_encryption_key == door_encryption_key
    card_encryption_key || door_encryption_key
  end

  def card_encryption_key
    @card_encryption_key ||= begin
      transform_with_loop_size(card_public_key, door_loop_size)
    end
  end

  def door_encryption_key
    @door_encryption_key ||= begin
      transform_with_loop_size(door_public_key, card_loop_size)
    end
  end
  
  def card_loop_size
    @card_loop_size ||= loop_size_of_target(card_public_key)
  end

  def door_loop_size
    @door_loop_size ||= loop_size_of_target(door_public_key)
  end

  def loop_size_of_target(target)
    subject_number = 7
    value = 1
    i = 0
    while value != target
      value = transform(value, subject_number)
      i += 1
    end
    i
  end

  def transform_with_loop_size(subject_number, loop_size)
    value = 1
    loop_size.times { value = transform(value, subject_number) }
    value
  end

  def transform(value, subject_number)
    value *= subject_number
    value %= divisor
  end
end

cb = ComboBreaker.new
puts "Part 1: " + cb.part_one_answer.to_s