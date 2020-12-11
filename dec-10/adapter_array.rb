class AdapterArray
  def initialize(file_name)
    @file = File.open(file_name).read.split("\n").map(&:to_i)
    @sorted_jolts = (@file << @file.max + 3 << 0).sort
    @D = Array.new(@sorted_jolts.max+1, 0)
  end

  def part_one_answer
    jolt_diff_counts[1] * jolt_diff_counts[3]
  end

  def part_two_answer
    total_arrangements
  end

  private

  def total_arrangements
    total_arrangements_from_jolt(0)
  end

  def total_arrangements_from_jolt(jolt)
    return 0 if @D[jolt].nil?
    return @D[jolt] if @D[jolt] != 0
    return @D[jolt] = 1 if jolt == @sorted_jolts.max
    (jolt+1..jolt+3).each do |next_jolt|
      if @sorted_jolts.include?(next_jolt)
        @D[jolt] += total_arrangements_from_jolt(next_jolt)
      end
    end
    @D[jolt]
  end

  def jolt_diff_counts
    return @jolt_diff_counts if @jolt_diff_counts
    jolt_diff_counts = Hash.new(0)
    (0..@sorted_jolts.size-2).each do |i|
      diff = @sorted_jolts[i+1] - @sorted_jolts[i]
      jolt_diff_counts[diff] += 1
    end
    @jolt_diff_counts = jolt_diff_counts
  end
end

aa = AdapterArray.new('input.txt')
puts "Part 1: " + aa.part_one_answer.to_s
puts "Part 2: " + aa.part_two_answer.to_s
