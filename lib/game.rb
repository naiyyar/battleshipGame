require 'byebug'
require_relative './player.rb'

# Need to take inputs 
  # grid size
  # number of ships
  # get p1 & p2 ships positions and place the grid
  # get p1 and p2 moves

# place player1 and 2 grids

class Game
  attr_reader :grid_size

  def initialize
    @grid_size = get_grid_size
    @player1_hits = @player2_hits = 0
    @player1 = Player.new(name: 'Player 1', grid_size: @grid_size)
    @player2 = Player.new(name: 'Player 2', grid_size: @grid_size)
  end

  def start
    place_ships

    total_missiles = get_total_missiles

    if total_missiles <= 0
      puts "Number of missiles should be greater than 0"
      return
    end

    p1_moves = @player1.get_moves
    p2_moves = @player2.get_moves

    puts "Player 1's turn:"
    @player2.display_grid
    p2_moves.each{|move| @player1.hit(*move) }

    puts "Player 2's turn:"
    @player1.display_grid
    p1_moves.each {|move| @player2.hit(*move) }

    @player1_hits, @player2_hits = @player1.hits_count, @player2.hits_count

    puts display_results
  end

  private

  def display_results
    puts 'Player1'
    print @player1.display_grid
    puts ''
    puts 'Player1'
    print @player2.display_grid
    puts ''
    puts "P1:#{@player1_hits}"
    puts "P2:#{@player2_hits}"
    
    result = if @player1_hits > @player2_hits
      'Player 1 wins'
    elsif @player2_hits > @player1_hits
      'Player 2 wins'
    else
      'It is a draw'
    end
    result
  end

  # get p1 & p2 ships positions and place ships on the grid
  def place_ships
    get_ship_size

    @player1.position_ships(get_p1_ships_positions)
    @player2.position_ships(get_p2_ships_positions)
  end

  def get_grid_size
    puts 'Enter grid size (e.g., 4): '
    gets.chomp.to_i
  end

  def get_ship_size
    puts 'Enter ship size (e.g., 4): '
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

  def get_total_missiles
    puts 'Enter missiles size (e.g., 4):'
    gets.chomp.to_i
  end
end