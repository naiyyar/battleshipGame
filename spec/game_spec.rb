RSpec.describe Game do
  describe '#initialize' do
    let(:game) { Game.new }

    it 'prompts the user to enter a grid size' do
      expect { game }.to output("Enter grid size (e.g., 4): \n").to_stdout
    end

    it 'initializes with the correct grid size' do
      expect(game.grid_size).to eq(game.send(:get_grid_size))
      expect(game.grid_size).to be_a(Integer)
    end

    it 'initializes two players' do
      expect(game.instance_variable_get(:@player1)).to be_a(Player)
      expect(game.instance_variable_get(:@player1)).to be_a(Player)
    end

    it 'initializes players with correct names and grid sizes' do
      expect(game.instance_variable_get(:@player1).name).to eq("Player 1")
      expect(game.instance_variable_get(:@player1).grids.length).to eq(game.send(:get_grid_size))
      expect(game.instance_variable_get(:@player2).name).to eq("Player 2")
      expect(game.instance_variable_get(:@player1).grids.length).to eq(game.send(:get_grid_size))
    end
  end

  describe '#start' do
    let(:game) { Game.new }

    before(:each) do
      game.instance_variable_set(:@grid_size, 2)
      allow(game).to receive(:place_ships)
      allow(game.instance_variable_get(:@player1)).to receive(:get_moves).and_return([[1, 1], [1, 2]])
      allow(game.instance_variable_get(:@player2)).to receive(:get_moves).and_return([[2, 2], [2, 1]])
      allow(game.instance_variable_get(:@player1)).to receive(:hit)
      allow(game.instance_variable_get(:@player2)).to receive(:hit)
      allow(game.instance_variable_get(:@player1)).to receive(:hits_count).and_return(1)
      allow(game.instance_variable_get(:@player2)).to receive(:hits_count).and_return(1)
      allow(game).to receive(:display_results)
    end

    context 'when total_missiles is greater than 0' do
      it 'plays the game' do
        allow(game).to receive(:get_total_missiles).and_return(2)
        game.instance_variable_set(:@p1_moves, [[1, 1], [1, 2]])
        game.instance_variable_set(:@p2_moves, [[2, 2], [2, 1]])
        expect { game.start }.to output(/Player 1's turn:/).to_stdout
        expect { game.start }.to output(/Player 2's turn:/).to_stdout
      end
    end

    context 'when total_missiles is 0' do
      it 'prints an error message' do
        allow(game).to receive(:get_total_missiles).and_return(0)
        allow(game).to receive(:puts)
        expect(game.start).to eq('Number of missiles should be greater than 0')
      end
    end
  end


  describe 'display_results' do
    let(:player1) { double('player1') }
    let(:player2) { double('player2') }

    let(:game) { Game.new }

    describe '#display_results' do
      before do
        allow(player1).to receive(:display_grid)
        allow(player2).to receive(:display_grid)
      end

      context 'when player 1 has more hits than player 2' do
        it 'displays Player 1 wins' do
          allow(game).to receive(:puts)
          allow(game).to receive(:print)
          game.instance_variable_set(:@player1_hits, 3)
          game.instance_variable_set(:@player2_hits, 2)
          expect(game.send(:display_results)).to eq('Player 1 wins')
        end
      end

      context 'when player 2 has more hits than player 1' do
        it 'displays Player 2 wins' do
          allow(game).to receive(:puts)
          allow(game).to receive(:print)
          game.instance_variable_set(:@player1_hits, 2)
          game.instance_variable_set(:@player2_hits, 3)
          expect(game.send(:display_results)).to eq('Player 2 wins')
        end
      end

      context 'when both players have equal hits' do
        it 'displays It is a draw' do
          allow(game).to receive(:puts)
          allow(game).to receive(:print)
          game.instance_variable_set(:@player1_hits, 2)
          game.instance_variable_set(:@player2_hits, 2)
          expect(game.send(:display_results)).to eq('It is a draw')
        end
      end
    end
  end
end
