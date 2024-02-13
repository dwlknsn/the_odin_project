const operandButtons = document.querySelectorAll('button.operand');
const operatorButtons = document.querySelectorAll('button.operator');
const equalsButton = document.querySelector('button#btn_equals');
const clearButton = document.querySelector('button#btn_clear');
const deleteButton = document.querySelector('button#btn_delete');
const runningCalcDiv = document.querySelector('#running-calculation');
const finalResultDiv = document.querySelector('#final-result');

operandButtons.forEach(button => {
  button.addEventListener('click', () => updateRunningCalc(button.textContent));
});

operatorButtons.forEach(button => {
  button.addEventListener('click', () => updateRunningCalc(button.textContent));
});

equalsButton.addEventListener('click', calculateResult);
clearButton.addEventListener('click', () => displayResult(0));
deleteButton.addEventListener('click', deleteLastInput);
document.addEventListener('keyup', parseKeyPress);

function parseKeyPress(key) {
  const regex = /[0-9-÷\/\.\+*x]/
  const str = key.key;
  if (str.match(/[0-9\.]/)) {
    return updateRunningCalc(str);
  } else if (str.match(/[\+\-\÷\/\x\*]/)) {
    return updateRunningCalc(parseOperatorFrom(str));
  } else if (str === '=' || str === 'Enter') {
    return calculateResult()
  } else if (str === 'Backspace') {
    return deleteLastInput();
  }
};

function parseOperatorFrom(key) {
  switch (key) {
    case '+':
    case '-':
    case 'x':
    case '÷':
      return key;
    case '*':
      return 'x';
    case '/':
      return '÷';
    default:
      break;
  }
}

// 
// CALCULATION LOGIC
// 

function calculateResult() {
  // https://medium.com/@shemar.gordon32/how-to-split-and-keep-the-delimiter-s-d433fb697c65
  // See this article for explanation of the regex matcher that keeps the delimiter in the 
  // resulting output. e.g.
  // "1x23.4+66.2÷3-4.24".split(/(?=[x÷\-\+])|(?<=[x÷\-\+])/g)
  // =>  ['1', 'x', '23.4', '+', '66.2', '÷', '3', '-', '4.24']

  const regex = /(?=[x÷\-\+])|(?<=[x÷\-\+])/g;
  const inputs = runningCalcDiv.textContent
                  .split(regex)
                  .map(x => parseFloat(x) || x);

  const initialValue = 0.0;
  let operand1;
  let operator;
  let operand2;

  const result = inputs.reduce((acc, nextInput) => {
    if (isNaN(operand1)) {
      operand1 = nextInput;
      return nextInput;
    }

    if (typeof(nextInput) === "string") {
      operator = nextInput;
      return acc;
    } else {
      operand2 = nextInput;
      return operate(operator, acc, operand2);
    }
  }, initialValue);

  displayResult(Math.round(result * 1_000_000) / 1_000_000);
};

function operate(operator, num1, num2) {
  const a = parseFloat(num1);
  const b = parseFloat(num2);

  switch (operator) {
    case '+':
      return a + b;
    case '-':
      return a - b;
    case 'x':
      return a * b;
    case '÷':
      return a / b;
    default:
      break;
  }
};

// 
// SCREEN UPDATE LOGIC
// 

function updateRunningCalc(value, mode = 'append') {

  switch (mode) {
    case 'append':
      let runningCalc = runningCalcDiv.textContent;

      if (runningCalc === '0' && value[0] !== '.') {
        return updateRunningCalc(value, 'overwrite'); // so that we don't show a leading zero on integer inputs.
      } else {
        return runningCalcDiv.textContent += value;
      }
    case 'overwrite':
      return runningCalcDiv.textContent = value;
    default:
      break;
  }

}

function displayResult(value) {
  updateRunningCalc(value, 'overwrite');
  finalResultDiv.textContent = value;
}

function deleteLastInput() {
  let runningCalc = runningCalcDiv.textContent.slice(0, -1);

  if (runningCalc.length === 0) {
    updateRunningCalc(0, 'overwrite');
  } else {
    updateRunningCalc(runningCalc, 'overwrite');
  }
};