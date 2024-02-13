const PLAYABLE_OPTIONS = ["rock", "paper", "scissors"];
const WINNING_SCORE = 5

let runningScorePlayer = 0;
let runningScoreComputer = 0;

function getComputerChoice() {
  const i = Math.floor(Math.random() * 3);
  result = PLAYABLE_OPTIONS[i];
  return result;
}

function getPlayerChoice() {
  const playerSelection = prompt(`Choose from: [${PLAYABLE_OPTIONS.join(", ")}]`).toLowerCase()
  
  if (PLAYABLE_OPTIONS.includes(playerSelection)) {
    return playerSelection
  } else {
    console.log("Please choose a valid option");
    return getPlayerChoice();
  }
}

function playRound(playerSelection, computerSelection = getComputerChoice()) {
  playerSelection = playerSelection.toLowerCase();
  computerSelection = computerSelection.toLowerCase();
  
  let text = '';
  
  if (playerSelection == computerSelection) {
    text = "This round is a tie! Let's play again...";
    return text;
  } else if (playerSelection == 'rock') {
    text = (computerSelection == 'paper') ? 'LOSE' : 'WIN';
  } else if (playerSelection == 'paper') {
    text = (computerSelection == 'scissors') ? 'LOSE' : 'WIN';
  } else if (playerSelection == 'scissors') {
    text = (computerSelection == 'rock') ? 'LOSE' : 'WIN';
  }
  
  let result = '';
  
  if (text == 'WIN') {
    runningScorePlayer++;
    result = `You WIN! ${playerSelection} beats ${computerSelection}`;
  } else {
    runningScoreComputer++;
    result = `You LOSE! ${computerSelection} beats ${playerSelection}`;
  }
  
  return result;
}

const resultsDisplay = document.querySelector('#results');
const currentGameResultSpan = document.querySelector('#currentGameResult');
const playerScoreSpan = document.querySelector('#playerScore');
const computerScoreSpan = document.querySelector('#computerScore');
const buttonContainer = document.querySelector('#buttonContainer');
const rockButton = document.querySelector('#rock');
const paperButton = document.querySelector('#paper');
const scissorsButton = document.querySelector('#scissors');
const resetButton = document.querySelector('#reset');

rockButton.addEventListener('click', () => {
  updateCurrentGame(playRound('rock'));
});

paperButton.addEventListener('click', () => {
  updateCurrentGame(playRound('paper'));
});

scissorsButton.addEventListener('click', () => {
  updateCurrentGame(playRound('scissors'));
});

resetButton.addEventListener('click', resetGame);

function updateCurrentGame(currentRoundResult) {
  currentGameResultSpan.textContent = currentRoundResult;
  updateRunningScoreDisplay();
  checkForWinner();
}

function updateRunningScoreDisplay() {
  playerScoreSpan.textContent = runningScorePlayer;
  computerScoreSpan.textContent = runningScoreComputer;
};

const winner = document.createElement('h1');

function checkForWinner() {
  if (runningScorePlayer === WINNING_SCORE) {
    winner.textContent = 'PLAYER WINS!'
    winner.style.border = '1px solid green';
    winner.style.color = 'green';
    endGame();
  } else if (runningScoreComputer === WINNING_SCORE) {
    winner.textContent = 'COMPUTER WINS!';
    winner.style.border = '1px solid red';
    winner.style.color = 'red';
    endGame();
  } else {
    return false;
  }
  
  return true;
}
function endGame() {
  resultsDisplay.appendChild(winner);
  rockButton.classList.add('hidden');
  paperButton.classList.add('hidden');
  scissorsButton.classList.add('hidden');
  resetButton.classList.remove('hidden');
}


function resetGame() {
  currentGameResultSpan.textContent = '';

  runningScorePlayer = 0;
  runningScoreComputer = 0;
  updateRunningScoreDisplay();
  
  resultsDisplay.removeChild(winner);

  rockButton.classList.remove('hidden');
  paperButton.classList.remove('hidden');
  scissorsButton.classList.remove('hidden');
  resetButton.classList.add('hidden');
}