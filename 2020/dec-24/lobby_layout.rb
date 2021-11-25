class LobbyLayout
  attr_accessor :directions
  def initialize(file_name)
    @directions = File.open(file_name).read.split("\n")
  end

  Location = Struct.new(:x, :y)

  def part_one_answer
    flips = Hash.new(0)
    directions.each do |direction|
      location = Location.new(0,0)
      i = 0
      while i < direction.length
        two_char_dirs = ["se", "sw", "nw", "ne"]
        one_char_dir = direction[i]
        two_char_dir = direction[i..i+1]
        if two_char_dirs.include?(two_char_dir)
          if two_char_dir == "se"
            location.x += 1
            location.y -= 1
          elsif two_char_dir == "sw"
            location.x -= 1
            location.y -= 1
          elsif two_char_dir == "nw"
            location.x -= 1
            location.y += 1
          elsif two_char_dir == "ne"
            location.x += 1
            location.y += 1
          end
          i += 2
        else
          if one_char_dir == "e"
            location.x += 2
          elsif one_char_dir == "w"
            location.x -= 2
          elsif one_char_dir == "s"
            location.y -= 2
          elsif one_char_dir == "n"
            location.y += 2
          end
          i += 1
        end
      end
      flips[location] += 1
    end
    flips.values.count { |val| val % 2 == 1 }
  end
end

ll = LobbyLayout.new('input.txt')
puts "Part 1: " + ll.part_one_answer.to_s
