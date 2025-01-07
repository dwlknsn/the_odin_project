console.log("connected");

function createGameboard() {
  const rows = 3;
  const cols = 3;
  const board = [];

  for (let i = 0; i < rows; i++) {
    board.push([])
    for (let j = 0; j < cols; j++) {
      board[i].push(1)
    }

  }

  const getBoard = () => board;
  const placeToken = (token, [x, y]) => {
    board[x][y] = token;
  }

  return { getBoard, placeToken }
}

const board = createGameboard();
board.placeToken("X", [2, 1]);
board.placeToken("X", [0, 1]);
board.placeToken("X", [1, 0]);
console.table(board.getBoard());
