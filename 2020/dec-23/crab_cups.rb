require 'set'

# TODO: refactor all of this
class CrabCups
  attr_accessor :argh
  def initialize
    @argh = "853192647".split("").map(&:to_i) + (10..1000000).to_a
  end

  def part_one_answer
    result = play_game(10000000)
    from_one(result.join(""))
  end

  def from_one(str)
    nums = str.split("")
    one_index = nums.index("1")
    (nums[one_index+1..] + nums[0..one_index-1])
  end

  def play_game(total_moves)
    nums = argh.clone
    n = nums.size
    i = 0
    while i < total_moves
      copy = nums.clone
      curr = i % n
      curr_num = nums[curr]

      indices = [(curr+1)%n, (curr+2)%n, (curr+3)%n]

      fst = nums[(curr+1)%n]
      snd = nums[(curr+2)%n]
      thr = nums[(curr+3)%n]

      nums.delete(fst)
      nums.delete(snd)
      nums.delete(thr)


      d_index = index_of_destination(curr_num, nums)
      nums.insert((d_index+1)% n, fst, snd, thr)

      new_index_of_curr = nums.index(curr_num)
      if new_index_of_curr < curr
        popped = nums.pop(curr - new_index_of_curr)
        popped.append(*nums)
        nums = popped
      elsif new_index_of_curr > curr
        dropped = nums.drop(new_index_of_curr - curr)
        dropped.append(*nums[0..(new_index_of_curr - curr)-1])
        nums = dropped
      end
      i += 1
    end
    nums
  end

  def index_of_destination(curr_num, nums)
    target = curr_num - 1
    while target >= 0
      if nums.include?(target)
        return nums.index(target)
      else
        target -= 1
      end
    end
    return nums.index(nums.max)
  end
end

cc = CrabCups.new
puts "Part 1: " + cc.part_one_answer.to_s