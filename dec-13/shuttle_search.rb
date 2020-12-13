class ShuttleSearch
  def initialize(file_name)
    @file = File.open(file_name).read.split("\n")
    @arrival_time = @file[0].to_i
    @bus_ids = @file[1].split(",").select { |elt| elt != "x" }.map(&:to_i)
  end

  def part_one_answer
    bus_id, wait_time = earliest_bus_id_and_wait_time
    bus_id * wait_time
  end

  def part_two_answer
    # Couldn't solve without a hint!
    0
  end

  def bus_ids_with_t
    @bus_ids_with_t ||= (@file[1].split(",").each_with_index.map do |id, index|
      if id != "x"
        [id.to_i, index]
      end
    end).select { |elt| elt }
  end

  def earliest_bus_id_and_wait_time
    @earliest_bus_id = nil
    @earliest_wait_time = Float::INFINITY
    @bus_ids.each do |bus_id|
      wait_time = wait_time(@arrival_time, bus_id)
      earlier_wait_time = [wait_time, @earliest_wait_time].min
      if earlier_wait_time == wait_time
        @earliest_wait_time = earlier_wait_time
        @earliest_bus_id = bus_id
      end
    end
    [@earliest_bus_id, @earliest_wait_time]
  end

  def wait_time(target, bus_id)
    closest_multiple = bus_id * (target.to_f / bus_id.to_f).ceil
    wait_time = closest_multiple - target
  end
end

ss = ShuttleSearch.new("input.txt")
puts "Part 1: " + ss.part_one_answer.to_s
puts "Part 2: " + ss.part_two_answer.to_s