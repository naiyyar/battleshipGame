class Player
  attr_accessor :name
  
  def initialize name:, grid_size:
    @name = name
    @grids = Array.new(grid_size){ Array.new(grid_size, '_') }
  end

  def display_grid
    @grids.each{|grid| puts grid.join(' ')}
  end

  def postions_ships positions
    positions.each do |position|
      # position => [1,2]
      row, col = position
      @grid[row][col] = 'B'
    end
  end
end