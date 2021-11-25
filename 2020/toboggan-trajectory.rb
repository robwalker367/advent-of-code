class TobogganTrajectory
  def initialize(file_name)
    @grid = File.open(file_name).read.split
  end

  def part_one_answer
    find_tree_count(1,3)
  end

  def part_two_answer
    answers = [[1,1],[3,1],[5,1],[7,1],[1,2]].map do |right, down|
      find_tree_count(right, down)
    end
    answers.reduce(&:*)
  end

  private

  def find_tree_count(right_shift, down_shift)
    grid_width = @grid[0].size
    tree_count = 0
    i, j = 0, 0
    while (next_line = @grid[i+down_shift])
      if next_line[(j+right_shift) % grid_width] == '#'
        tree_count += 1
      end
      i += down_shift
      j += right_shift
    end
    tree_count
  end
end

tt = TobogganTrajectory.new('input.txt')
puts "Part 1: " + tt.part_one_answer.to_s
puts "Part 2: " + tt.part_two_answer.to_s