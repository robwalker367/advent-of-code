# TODO: refactor all of this!
class RainRisk
  def initialize(file_name)
    @file = File.open(file_name).read.split("\n")
    @instructions = @file.map do |line|
      Instruction.new(line[0], line[1..].to_i)
    end
    @ship = Ship.new(0, 0, 0)
    @waypoint = Waypoint.new(10, 1)
  end

  def part_one_answer
    @instructions.each do |instruction|
      execute_assumed_instruction(instruction)
    end
    manhattan_distance
  end

  def part_two_answer
    @ship.x = 0
    @ship.y = 0
    @ship.direction = direction_to_waypoint
    @instructions.each do |instruction|
      execute_manual_instruction(instruction)
    end
    manhattan_distance
  end

  private

  Instruction = Struct.new(:action, :value)
  Ship = Struct.new(:x, :y, :direction)
  Waypoint = Struct.new(:x, :y)

  def manhattan_distance
    @ship.x.abs + @ship.y.abs
  end

  def execute_manual_instruction(instruction)
    if ["N","S","W","E"].include?(instruction.action)
      translate_obj_nswe(@waypoint, instruction.action, instruction.value)
      @ship.direction = direction_to_waypoint
    elsif instruction.action == "F"
      instruction.value.times { move_to_waypoint }
    elsif instruction.action == "L"
      rotate_waypoint(instruction.value)
    elsif instruction.action == "R"
      rotate_waypoint(-instruction.value)
    end
  end

  def move_to_waypoint
    x_distance_to_waypoint = @waypoint.x - @ship.x
    y_distance_to_waypoint = @waypoint.y - @ship.y
    @ship.x += x_distance_to_waypoint
    @ship.y += y_distance_to_waypoint
    @waypoint.x += x_distance_to_waypoint
    @waypoint.y += y_distance_to_waypoint
  end

  def direction_to_waypoint
    delta_x = @waypoint.x - @ship.x
    delta_y = @waypoint.y - @ship.y
    rad_to_deg(Math.atan2(delta_y, delta_x))
  end

  def rotate_waypoint(degrees)
    x = @waypoint.x - @ship.x
    y = @waypoint.y - @ship.y
    theta = deg_to_rad(degrees)
    x_p = (x * Math.cos(theta)) - (y * Math.sin(theta))
    y_p = (y * Math.cos(theta)) + (x * Math.sin(theta))
    x_p += @ship.x
    y_p += @ship.y
    @waypoint.x = x_p
    @waypoint.y = y_p
  end

  def execute_assumed_instruction(instruction)
    if ["N","S","W","E"].include?(instruction.action)
      translate_obj_nswe(@ship, instruction.action, instruction.value)
    elsif instruction.action == "L"
      @ship.direction += instruction.value
      @ship.direction = @ship.direction % 360
    elsif instruction.action == "R"
      @ship.direction -= instruction.value
      @ship.direction = @ship.direction % 360
    elsif instruction.action == "F"
      direction = @ship.direction
      amount_to_move = instruction.value
      x_shift = (Math.cos(deg_to_rad(direction)) * amount_to_move).to_i
      y_shift = (Math.sin(deg_to_rad(direction)) * amount_to_move).to_i
      @ship.x += x_shift
      @ship.y += y_shift
    end
  end

  def translate_obj_nswe(obj, nswe_val, val)
    if nswe_val == "N"
      obj.y += val
    elsif nswe_val == "S"
      obj.y -= val
    elsif nswe_val == "W"
      obj.x -= val
    elsif nswe_val == "E"
      obj.x += val
    end
  end

  def distance_between(obj1, obj2)
    Math.sqrt((obj1.x.abs - obj2.x.abs) ** 2 + (obj1.y - obj2.y) ** 2)
  end
  
  def deg_to_rad(deg)
    deg * Math::PI / 180
  end

  def rad_to_deg(rad)
    rad * 180 / Math::PI
  end
end

rr = RainRisk.new('input.txt')
puts "Part 1: " + rr.part_one_answer.to_s
puts "Part 2: " + rr.part_two_answer.to_s
