#spec/tic_tac_toe_spec.rb

require './lib/tic_tac_toe.rb'

describe Player do
  describe '#initialize' do
    subject(:player_initialized) { described_class.new('Player 1', 'X') }

    it 'adds instance of Player into an array of players' do
      array = Player.class_variable_get(:@@players)
      expect(array).to include(player_initialized)
    end
  end

  describe '#mark_on_board' do
    context 'when user inputs a valid position' do
      let(:valid_position) { 'C1R1' }
      player_valid_input = described_class.new('Player 1', 'X')

      context 'when the position on the board is empty' do
        before do
          allow(player_valid_input).to receive(:gets).and_return(valid_position)
        end

        it "saves player's mark in the valid board position" do
          player_valid_input.mark_on_board

          board = Board.class_variable_get(:@@board)
          board_position = board[valid_position.to_sym]
          mark = player_valid_input.mark
          expect(board_position).to eq(mark)
        end

        it 'adds position into an array of already marked positions' do
          expect(player_valid_input.marked).to include(valid_position)
        end

        it 'does not display any puts statements' do
          expect(player_valid_input).not_to receive(:puts)
        end
      end
    end
  end
end
