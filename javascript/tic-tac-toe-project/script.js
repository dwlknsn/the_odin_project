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

function createPlayer(name, token) {
  const getName = () => name;
  const getToken = () => token;

  return { getName, getToken }
}

function gameController(player1, player2) {
  const players = [player1, player2];
  const board = createGameboard();
  const maxTurnCount = 9;

  let currentPlayer = players[0];
  let currentTurnCount = 1;

  const getCurrentPlayer = () => currentPlayer;
  const getNextPlayer    = () => (currentPlayer == players[0]) ? players[1] : players[0];
  const switchPlayer     = () => currentPlayer = getNextPlayer()

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
    let valid;
    let gameOver;
    let msg;

    if (board.placeToken(currentPlayer.getToken(), row, col)) {
      if (gameWon()) {
        valid = true;
        gameOver = true;
        msg = `GAME OVER - ${currentPlayer.getName()} is the winner`;

        console.log(msg);
        board.printBoard();
      } else if (noMovesAvailable()) {
        valid = true;
        gameOver = true;
        msg = `GAME OVER - No more moves available`;

        console.log(msg);
        board.printBoard();
      } else {
        valid = true;
        gameOver = false;
        msg = `Continue`;

        currentTurnCount++
        switchPlayer();
        printNewRound();
      }
    } else {
      gameOver = false;
      msg = `FAIL - Invalid position ${[row, col]}`;
    }
    return { valid, gameOver, msg };
  }

  const getBoard = () => board.getBoard();

  printNewRound();
  return { playRound, getBoard, getCurrentPlayer, getNextPlayer }
}

function UIController(game) {
  const gameboardContainerDiv = document.querySelector("#gameboard-container");
  const resultDiv = document.querySelector("#result")
  const currentPlayerDiv = document.querySelector("#current-player");

  const updateCurrentPlayerDiv = (playerName) => {
    currentPlayerDiv.textContent = `Current Player: ${playerName}`;
  }

  const buildBoardUI = (board) => {
    const gameboardDiv = document.createElement("div");
    gameboardDiv.id = "gameboard";
    gameboardContainerDiv.appendChild(gameboardDiv);

    const cellTemplate = document.querySelector("#cell-template");

    board.forEach((row, rowIndex) => {
      row.forEach((_col, colIndex) => {
        const newCell = cellTemplate.content.cloneNode(true);
        const dataCellId = `${rowIndex}-${colIndex}`;
        const selectorId = `cell-${dataCellId}`;

        newCell.querySelector(".cell").id = selectorId;
        gameboardDiv.appendChild(newCell);

        gameboardDiv.querySelector(`#${selectorId}`).dataset.cellId = dataCellId;
      })
    });

    gameboardContainerDiv.addEventListener("click", gameboardClickHandler);
  }

  const gameboardClickHandler = (event) => {
    const cell = event.target;
    const dataCellId = cell.dataset.cellId;

    if (dataCellId == null) return;

    const [row, col] = dataCellId.split("-");
    const currentPlayer = game.getCurrentPlayer();
    const nextPlayer = game.getNextPlayer();
    const result = game.playRound(row, col);

    if ( result.valid ) {
      cell.classList.add(`token-${currentPlayer.getToken()}`);

      if ( result.gameOver ) {
        gameboardContainerDiv.removeEventListener("click", gameboardClickHandler);
        resultDiv.textContent = result.msg;
      } else {
        updateCurrentPlayerDiv(nextPlayer.getName());
      }
    } else {
      // do nothing
      console.log(result.msg)
    }
  }

  const startGame = () => {
    resultDiv.innerHTML = null;
    gameboardContainerDiv.innerHTML = null;
    buildBoardUI(game.getBoard());
    updateCurrentPlayerDiv(game.getCurrentPlayer().getName());
  }

  return { startGame }
}


// game.playRound(0, 0);
// game.playRound(1, 1);
// game.playRound(2, 2);
// game.playRound(0, 2);
// game.playRound(1, 2);
// game.playRound(1, 0);
// game.playRound(0, 1);
// game.playRound(2, 1);
// game.playRound(2, 0);

const player1 = createPlayer("Bob", "X");
const player2 = createPlayer("Liz", "O");
const game = gameController(player1, player2);
UIController(game).startGame();
