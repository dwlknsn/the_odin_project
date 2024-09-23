require_relative "../lib/game"

RSpec.describe Game do
  describe "#play" do
    subject(:game) { described_class.new }

    before do
      allow(game).to receive(:display_introduction)
      allow(game).to receive(:display_turn_order)
    end

    context "when the game is over" do
      it "does not call display_turn_order" do
        allow(game).to receive(:game_over?).and_return(true)
        expect(game).not_to receive(:display_turn_order)
        game.play
      end
    end

    context "when the game is over after the next turn" do
      it "breaks the loop after calling display_turn_order one more time" do
        allow(game).to receive(:game_over?).and_return(false, true)
        expect(game).to receive(:display_turn_order).once
        game.play
      end
    end
  end

  describe "#display_turn_order" do
    subject(:game) { described_class.new(board: board) }
    let(:board) { instance_double(Board) }

    before do
      allow(board).to receive(:display)
      allow(game).to receive(:next_player_move)
      allow(game).to receive(:puts)
    end

    it "increases turn_count by one" do
      expect { game.display_turn_order }.to change { game.turn_count }.by(1)
    end
  end

  describe "#next_player_move" do
    subject(:game) { described_class.new(board: board) }
    let(:board) { instance_double(Board) }
    let(:player) { instance_double(Player, name: "Player 1", marker: "🔴") }
    let(:column_number) { 1 }

    context "when the user inputs a valid column number on the first attempt" do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:current_player).and_return(player)
        allow(game).to receive(:get_player_input).and_return(column_number)
        allow(board).to receive(:drop_piece).and_return(true)
      end

      it "breaks the loop after calling board.drop_piece one time" do
        expect(board).to receive(:drop_piece).with(column_number, player.marker).once
        game.next_player_move
      end
    end

    context "when the user inputs a valid column number on the second attempt" do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:current_player).and_return(player)
        allow(game).to receive(:get_player_input).and_return(column_number)
        allow(board).to receive(:drop_piece).and_return(false, true)
      end

      it "breaks the loop after calling board.drop_piece twice" do
        expect(board).to receive(:drop_piece).with(column_number, "🔴").twice
        game.next_player_move
      end
    end
  end

  describe "#current_player" do
    subject(:game) { described_class.new }

    context "when the turn_count is odd" do
      it "returns player_1" do
        [1, 3, 5].each do |turn_count|
          allow(game).to receive(:turn_count).and_return(turn_count)
          expect(game.current_player).to eq(game.player_1)
        end
      end
    end

    context "when the turn_count is even" do
      it "returns player_2" do
        [2, 4, 6].each do |turn_count|
          allow(game).to receive(:turn_count).and_return(turn_count)
          expect(game.current_player).to eq(game.player_2)
        end
      end
    end
  end

  describe "#game_over?" do
    subject(:game) { described_class.new(board: board) }
    let(:board) { instance_double(Board) }

    context "when the board has a winning combination" do
      before do
        allow(board).to receive(:winner?).and_return(true)
        allow(game).to receive(:display_winner)
      end

      it "returns true" do
        expect(game.game_over?).to be true
      end
    end

    context "when the board does not have a winning combination and is not yet full" do
      before do
        allow(board).to receive(:winner?).and_return(false)
        allow(board).to receive(:full?).and_return(false)
      end

      it "returns false" do
        expect(game.game_over?).to be false
      end
    end

    context "when the game is a draw" do
      before do
        allow(board).to receive(:winner?).and_return(false)
        allow(board).to receive(:full?).and_return(true)
        allow(game).to receive(:display_draw)
      end

      it "returns true" do
        expect(game.game_over?).to be true
      end
    end
  end
end
