class SeatingSystem
  def initialize(file_name)
    @file = File.open(file_name).read.split("\n")
    @grid = @file.map { |row| row.split("") }
    @grid_p2 = deep_clone(@grid)
    @width = @grid[0].size
    @height = @grid.size
  end

  def part_one_answer
    find_next_state
    while @next_state != @grid
      @grid = deep_clone(@next_state)
      find_next_state
    end
    total_occupied_seats(@next_state)
  end

  def part_two_answer
    @grid = deep_clone(@grid_p2)
    find_next_state_p2
    while @next_state != @grid
      @grid = deep_clone(@next_state)
      find_next_state_p2
    end
    total_occupied_seats(@next_state)
  end

  private

  # TODO: Refactor find_next_state and find_next_state_p2
  def find_next_state
    @next_state = deep_clone(@grid)
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        next if cell == "."
        adjacent_seats = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
        occupied_seats = adjacent_seats.count do |i,j|
          next if out_of_bounds?(row_index+i, col_index+j) 
          @grid[row_index + i][col_index + j] == "#"
        end
        if cell == "L" && occupied_seats == 0
          @next_state[row_index][col_index] = "#"
        elsif cell == "#" && occupied_seats > 3
          @next_state[row_index][col_index] = "L"
        end
      end
    end
    @next_state
  end

  def find_next_state_p2
    @next_state = deep_clone(@grid)
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        next if cell == "."
        seat_directions = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
        occupied_seats = seat_directions.count do |i,j|
          seat = seat_in_direction(row_index, col_index, i, j)
          seat == "#"
        end
        if cell == "L" && occupied_seats == 0
          @next_state[row_index][col_index] = "#"
        elsif cell == "#" && occupied_seats > 4
          @next_state[row_index][col_index] = "L"
        end
      end
    end
    @next_state
  end

  def seat_in_direction(row, col, i, j)
    return if out_of_bounds?(row+i, col+j)
    cell = @grid[row+i][col+j]
    return cell if cell == "L" || cell == "#"
    if cell == '.' 
      seat_in_direction(row+i, col+j, i, j)
    end
  end

  def out_of_bounds?(row, col)
    row < 0 || row > @height-1 || col < 0 || col > @width-1
  end

  def total_occupied_seats(grid)
    grid.reduce(0) do |sum, row|
      sum + row.count { |cell| cell == "#" }
    end
  end

  def print(grid)
    grid.each do |row|
      puts row.join
    end
  end

  def deep_clone(grid)
    grid.clone.map(&:clone)
  end
end

ss = SeatingSystem.new('input.txt')
puts "Part 1: " + ss.part_one_answer.to_s
puts "Part 2: " + ss.part_two_answer.to_s
