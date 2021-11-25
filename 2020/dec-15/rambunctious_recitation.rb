class RambunctiousRecitation
  Tracker = Struct.new(:times_spoken, :last_index, :snd_last_index)

  def part_one_answer
    find_nth_number_naive([6,19,0,5,7,13,1], 2020)
  end

  def part_two_answer
    find_nth_number([6,19,0,5,7,13,1], 30000000)
  end

  private

  def find_nth_number_naive(nums, endpoint)
    i = nums.size
    last_spoken = nums[i-1]
    while i < endpoint
      if nums[0..i-1].count(last_spoken) == 1
        nums << 0
      else
        nums << i-1 - nums[0..i-2].rindex(last_spoken)
      end
      i += 1
      last_spoken = nums[i-1]
    end
    last_spoken
  end

  def find_nth_number(nums, endpoint)
    hash = Hash.new
    nums.each_with_index { |num, i| hash[num] = Tracker.new(1, i, nil) }
    last_spoken_num = nums.last
    last_spoken = hash[nums.last]
    i = nums.size
    while i < endpoint
      last_spoken_num = (last_spoken.times_spoken == 1) ? 
        0 : i-1 - last_spoken.snd_last_index
      if hash.key?(last_spoken_num)
        hash[last_spoken_num].times_spoken += 1
        hash[last_spoken_num].snd_last_index = hash[last_spoken_num].last_index
        hash[last_spoken_num].last_index = i
      else
        hash[last_spoken_num] = Tracker.new(1, i, nil)
      end
      last_spoken = hash[last_spoken_num]
      i += 1
    end
    last_spoken_num
  end
end

rr = RambunctiousRecitation.new
puts "Part 1: " + rr.part_one_answer.to_s
puts "Part 2: " + rr.part_two_answer.to_s