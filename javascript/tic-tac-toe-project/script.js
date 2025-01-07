const myBoard = (function createGameboard() {
  const rows = 3;
  const cols = 3;
  const board = [];

  for (let i = 0; i < rows; i++) {
    board.push([])

    for (let j = 0; j < cols; j++) {
      board[i].push(null);
    }
  }

  const winningCombos = [
    // winning rows:
    [[0, 0], [1, 0], [2, 0]],
    [[0, 1], [1, 1], [2, 1]],
    [[0, 2], [1, 2], [2, 2]],
    // winning cols:
    [[0, 0], [0, 1], [0, 2]],
    [[1, 0], [1, 1], [1, 2]],
    [[2, 0], [2, 1], [2, 2]],
    // winning diagonals
    [[0, 0], [1, 1], [2, 2]],
    [[0, 2], [1, 1], [2, 0]]
  ]

  const getBoard = () => board;
  const positionAvailable = ([x, y]) => {
    const validRow = x >= 0 && x <= rows;
    const validCol = y >= 0 && y <= cols;

    if (validRow && validCol) {
      return getBoard()[x][y] === null;
    }
    return false
  }
  const placeToken = (token, [x, y]) => { getBoard()[x][y] = token; }
  const winner = (token) => {
    return winningCombos.some((arr) => {
      return arr.map(([x, y]) => { return getBoard()[x][y] == token; })
                .every(bool => bool);
    })
  }

  return { getBoard, positionAvailable, placeToken, winner }
})();

function createPlayer(name, token) {
  const getName = () => name;
  const getToken = () => token;
  return { getName, getToken }
}

const bob = createPlayer("Bob", "X");
const liz = createPlayer("Liz", "0");

const result = (function createGame(board, player1, player2) {
  const players = [player1, player2];
  let currentPlayer = player1;
  let turnCount = 0;
  const maxTurnCount = 9;

  const getUserInput = () => {
    let x, y, positionAvailable;

    while (!positionAvailable) {
      [x, y] = prompt(`${currentPlayer.getName()}: Enter position XY`);
      positionAvailable = board.positionAvailable([x, y])
      console.log(`positionAvailable: ${positionAvailable}`)
    }
    return [x, y]
  }

  while (turnCount < maxTurnCount) {
    board.placeToken(currentPlayer.getToken(), getUserInput());
    console.log(board.getBoard().toString())
    if (board.winner(currentPlayer.getToken())) {
      return`${currentPlayer.getName()} is the winner!`;
    };
    turnCount++;
    currentPlayer = players[turnCount % 2];
  }

  return "The game is a draw."
})(myBoard, bob, liz);

console.log(result)
