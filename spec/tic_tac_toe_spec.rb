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

      before do
        allow(Board).to receive(:display)
        allow(player_valid_input).to receive(:print)
      end

      context "when the board's position is empty" do
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

      context "when the board's position is not empty" do
        before do
          another_valid_position = 'C2R2'
          allow(player_valid_input).to receive(:gets).and_return(valid_position, another_valid_position)
        end

       it 'calls for another input' do
          expect(player_valid_input).to receive(:mark_on_board).once
          player_valid_input.mark_on_board
        end
      end
    end
    
    context 'when user inputs an invalid position' do
      player_invalid_input = described_class.new('Player 2', 'O')

      before do
        allow(Game).to receive(:help)
        allow(player_invalid_input).to receive(:print)

        invalid_position = 'C4R4'
        valid_position = 'C3R3'

        allow(player_invalid_input).to receive(:gets).and_return(invalid_position, valid_position)
      end

      it "displays error message" do
        error_message = 'Wrong syntax.'
        expect(player_invalid_input).to receive(:puts).with(error_message).once
        player_invalid_input.mark_on_board
      end
    end
  end

  describe 'Game.winner?' do
    subject(:player_wins) { described_class.new('Player 1', 'X') }

    it "returns true if player's marks match a way to win" do
      allow(player_wins.marked).to receive(:include?).and_return(true)
      result = Game.winner?
      expect(player_wins.winner).to be(true)
    end

    it "returns false if player's marks don't match any ways to win" do
      allow(player_wins.marked).to receive(:include?)
      result = Game.winner?
      expect(player_wins.winner).to be(false)
    end
  end
end
