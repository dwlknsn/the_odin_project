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

  const getBoard = () => board;
  const placeToken = (token, [x, y]) => { board[x][y] = token; }
  const winner = (token) => {
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

    return winningCombos.some((arr) => {
      return arr.map(([x, y]) => { return board[x][y] == token; })
                .every(bool => bool);
    })
  }

  return { getBoard, placeToken, winner }
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
  let turnCount = 0;
  let currentPlayer = player1;

  while (turnCount < 9) {
    console.log(`Player: ${currentPlayer.getName()}`)
    const [x, y] = prompt("enter position XY (00, 01, 02, 10 ... 22)");
    board.placeToken(currentPlayer.getToken(), [x, y]);
    console.table(board.getBoard());
    if ( board.winner(currentPlayer.getToken()) ) { return `${currentPlayer.getName()} is the winner!`; break };
    turnCount++;
    currentPlayer = players[turnCount % 2];
  }

  return "The game is a draw."
})(myBoard, bob, liz);

console.log(result)
