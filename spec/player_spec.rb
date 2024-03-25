RSpec.describe Player do
  let(:grid_size) { 5 }

  describe '#initialize' do
    it 'creates a player with the given name and grid size' do
      player = Player.new(name: 'Player', grid_size: grid_size)
      expect(player.name).to eq 'Player'
      expect(player.grids.size).to eq grid_size
      expect(player.grids.all? { |row| row.size == grid_size }).to be true
      expect(player.hits_count).to eq 0
    end
  end

  describe '#display_grid' do
    it 'displays the grid' do
      player = Player.new(name: 'Player', grid_size: grid_size)
      expect { player.display_grid }.to output("#{(['_'] * grid_size).join(' ')}\n" * grid_size).to_stdout
    end
  end

  describe '#position_ships' do
    it 'Should accept :positions array as an argument and positions ships correctly' do
      player = Player.new(name: 'Player', grid_size: grid_size)
      positions = [[1, 2], [3, 4]]
      player.position_ships(positions)
      positions.each do |row, col|
        expect(player.grids[row][col]).to eq 'B'
      end
    end
  end

  describe '#hit' do
    context 'when hitting a ship' do
      it 'Should accept :row and :col as an arguments and marks the hit and increments the hits count' do
        player = Player.new(name: 'Player', grid_size: grid_size)
        player.position_ships([[1, 2]])
        player.hit(1, 2)
        expect(player.grids[1][2]).to eq 'X'
        expect(player.hits_count).to eq 1
      end
    end

    context 'when missing the ship' do
      it 'Should accept :row and :col as an arguments and marks the miss' do
        player = Player.new(name: 'Player', grid_size: grid_size)
        player.position_ships([[1, 2]])
        player.hit(0, 0)
        expect(player.grids[0][0]).to eq 'O'
      end
    end
  end

  describe '#get_moves' do
    it 'prompts the user for moves' do
      allow_any_instance_of(Object).to receive(:gets).and_return("1,1:2,0:2,3:3,4\n")
      player = Player.new(name: 'Player', grid_size: grid_size)
      expect(player.get_moves).to eq [[1, 1], [2, 0], [2, 3], [3, 4]]
    end
  end
end
