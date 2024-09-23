require_relative "../lib/board"

RSpec.describe Board do
  subject(:board) { described_class.new(verbose_output: false) }

  describe "#initialize" do
    it "initializes all cells as empty" do
      expect(board.grid.flatten.map(&:strip).all?(&:empty?)).to be true
    end
  end

  describe "#drop_piece" do
    context "when the move is valid" do
      before { allow(board).to receive(:valid_move?).and_return(true) }

      let(:column_number) { 1 }
      let(:marker) { "X" }

      it "returns true" do
        expect(board.drop_piece(column_number, marker)).to be true
      end

      it "adds a marker specified column" do
        allow(board).to receive(:available?).and_return(true)

        expect { board.drop_piece(column_number, marker) }
          .to change { board.grid[0][column_number] }.from("  ").to(marker)
      end

      it "adds a marker to the third row when the first two rows are occupied" do
        allow(board).to receive(:available?).and_return(false, false, true)

        expect { board.drop_piece(column_number, marker) }
          .to change { board.grid[2][column_number] }.from("  ").to(marker)
      end
    end

    context "when the move is invalid" do
      before { allow(board).to receive(:valid_move?).and_return(false) }

      let(:column_number) { 1 }
      let(:marker) { "X" }

      it "returns false" do
        expect(board.drop_piece(column_number, marker)).to be false
      end

      it "does not place the marker" do
        expect { board.drop_piece(column_number, marker) }
          .not_to change { board.grid[0][column_number] }
      end
    end
  end

  describe "#winner?" do
    let(:marker) { "X" }

    context "when there is a winner" do
      it "returns true when there is a horizontal win" do
        board.drop_piece(1, marker)
        board.drop_piece(2, marker)
        board.drop_piece(3, marker)
        board.drop_piece(4, marker)

        expect(board.winner?(marker)).to be true
      end

      it "returns true when there is a vertical win" do
        board.drop_piece(1, marker)
        board.drop_piece(1, marker)
        board.drop_piece(1, marker)
        board.drop_piece(1, marker)

        expect(board.winner?(marker)).to be true
      end

      it "returns true when there is a forward+up ↗️ sloping diagonal win" do
        board.drop_piece(1, marker)
        board.drop_piece(2, "0")
        board.drop_piece(2, marker)
        board.drop_piece(3, "0")
        board.drop_piece(3, "0")
        board.drop_piece(3, marker)
        board.drop_piece(4, "0")
        board.drop_piece(4, "0")
        board.drop_piece(4, "0")
        board.drop_piece(4, marker)

        expect(board.winner?(marker)).to be true
      end

      it "returns true when there is a forward+down ↘ sloping diagonal win" do
        board.drop_piece(1, "0")
        board.drop_piece(1, "0")
        board.drop_piece(1, "0")
        board.drop_piece(1, marker)
        board.drop_piece(2, "0")
        board.drop_piece(2, "0")
        board.drop_piece(2, marker)
        board.drop_piece(3, "0")
        board.drop_piece(3, marker)
        board.drop_piece(4, marker)

        expect(board.winner?(marker)).to be true
      end
    end

    context "when there is no winner" do
      it "returns false when there is no winner" do
        allow(board).to receive(:winning_rows?).and_return(false)
        allow(board).to receive(:winning_columns?).and_return(false)
        allow(board).to receive(:winning_diagonals?).and_return(false)

        expect(board.winner?(marker)).to be false
      end
    end
  end

  describe "#full?" do
    subject(:board) { described_class.new }

    context "when the board is full" do
      it "returns true" do
        count = board.rows * board.columns
        expect(board.full?(count)).to be true
      end
    end

    context "when the board is not full" do
      it "returns false" do
        count = board.rows * board.columns - 1
        expect(board.full?(count)).to be false
      end
    end
  end
end
