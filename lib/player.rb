# display grid
# palce ship postions on grid
# hit results
# get moves

class Player
  attr_accessor :name, :hits_count
  
  def initialize name:, grid_size:, moves:
    @name = name
    @grids = Array.new(grid_size){ Array.new(grid_size, '_') }
    @hits_count = 0
    @move = moves
  end

  def display_grid
    @grids.each{|grid| puts grid.join(' ')}
  end

  def position_ships positions
    positions.each do |position|
      # position => [1,2]
      row, col = position
      @grids[row][col] = 'B'
    end
  end

  def hit(row, col)
    # byebug
    if @grids[row][col] == 'B'
      @grids[row][col] = 'X'
      self.hits_count += 1
    else
      @grids[row][col] = 'O'
    end
  end

  def get_moves
    puts "Enter #{name} moves (x,y pairs separated by colon, eg; 1,1:2,0:2,3:3,4,..):"
    @move.split(':').map{|rc| rc.split(",").map(&:to_i)}
  end
end