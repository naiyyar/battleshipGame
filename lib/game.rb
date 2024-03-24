require_relative './player.rb'

# Need to take inputs 
  # grid size
  # number of ships
  # get p1 & p2 ships positions and place the grid
  # get p1 and p2 moves

# place player1 and 2 grids

class Game
  def initialize
    @grid_size = get_grid_size
    @total_ships = get_ship_size
  end

  def start
    # Initialize players grids
    player1 = Player.new(name: 'Player 1', grid_size: @grid_size)
    player2 = Player.new(name: 'Player 2', grid_size: @grid_size)

    # get p1 & p2 ships positions and place ships on the grid
    p1_ships_positions = get_p1_ships_positions
    p2_ships_positions = get_p2_ships_positions

    player1.postions_ships(p1_ships_positions)
    player2.postions_ships(p2_ships_positions)

    player1.display_grid
  end

  private

  def get_grid_size
    puts 'Enter grid size (e.g., 4):'
    gets.chomp.to_i
  end

  def get_ship_size
    puts 'Enter grid size (e.g., 4):'
    gets.chomp.to_i
  end

  def get_p1_ships_positions
    puts 'Enter player1 ships positions (x,y pairs separated by colon, eg; 1,1:2,0:2,3:3,4,...):'
    gets.chomp.split(':').map{|rc| rc.split(",").map(&:to_i)}
  end

  def get_p2_ships_positions
    puts 'Enter player2 ships positions (x,y pairs separated by colon, eg; 1,1:2,0:2,3:3,4,...):'
    gets.chomp.split(':').map{|rc| rc.split(",").map(&:to_i)}
  end

end