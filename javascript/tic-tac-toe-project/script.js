function createGameboard() {
  const rows = 3;
  const cols = 3;
  const board = [];

  const buildBoard = (() => {
    for (let i = 0; i < rows; i++) {
      board.push([])

      for (let j = 0; j < cols; j++) {
        board[i].push(null);
      }
    }
  })();

  const getBoard = () => board;

  const printBoard = () => { board.forEach(row => console.log(row)); }

  const positionAvailable = (row, col) => {
    const validRow = row >= 0 && row <= rows;
    if (!validRow) return false;

    const validCol = col >= 0 && col <= cols;
    if (!validCol) return false;

    return board[row][col] === null;
  }

  const placeToken = (token, row, col) => {
    if (positionAvailable(row, col)) {
      console.log(`Placing token ${token} at position row ${row}, col ${col}`)
      board[row][col] = token;
      return true;
    } else {
      return false;
    }
  }

  return { getBoard, printBoard, placeToken }
};

function gameController(player1, player2) {
  const players = [player1, player2];
  const board = createGameboard();
  const maxTurnCount = 9;

  let currentPlayer = players[0];
  let currentTurnCount = 1;

  const switchPlayer = () => { currentPlayer = (currentPlayer == players[0]) ? players[1] : players[0]; }
  // const getCurrentPlayer = () => currentPlayer;

  const printNewRound = () => {
    board.printBoard();
    console.log(`Turn ${currentTurnCount} - ${currentPlayer.getName()}'s turn.`);
  };

  const gameWon = () => {
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
      return arr.map(([row, col]) => {
        return board.getBoard()[row][col] == currentPlayer.getToken();
      }).every(bool => bool);
    })
  }

  const noMovesAvailable = () => {
    console.log(currentTurnCount)
    return currentTurnCount == maxTurnCount;
  }

  const playRound = (row, col) => {
    if (board.placeToken(currentPlayer.getToken(), row, col)) {
      if (gameWon()) {
        console.log(`GAME OVER - ${currentPlayer.getName()} is the winner`);
        console.log("Final Board State:");
        board.printBoard();
      } else if (noMovesAvailable()) {
        console.log(`GAME OVER - No more moves available`);
        console.log("Final Board State:");
        board.printBoard();
      } else {
        currentTurnCount++
        switchPlayer();
        printNewRound();
      }
    } else {
      console.log(`FAIL - Invalid position ${[row, col]}`)
    }
  }

  printNewRound();
  return { playRound }
}

function createPlayer(name, token) {
  const getName = () => name;
  const getToken = () => token;

  return { getName, getToken }
}

const bob = createPlayer("Bob", "X");
const liz = createPlayer("Liz", "0");
const game = gameController(bob, liz);
game.playRound(0, 0);
game.playRound(1, 1);
game.playRound(2, 2);
game.playRound(0, 2);
game.playRound(1, 2);
game.playRound(1, 0);
game.playRound(0, 1);
game.playRound(2, 1);
game.playRound(2, 0);
