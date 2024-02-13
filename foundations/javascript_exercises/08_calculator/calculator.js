const add = function(a, b) {
  return a + b;
};

const subtract = function(a, b) {
	return a - b;
};

const sum = function(array) {
  // let memo = 0;

  // array.forEach(num => {
  //   memo += num;
  // });

  // return memo;

  return array.reduce((total, current) => total + current, 0);
};

const multiply = function(array) {
  // let memo = 1;

  // array.forEach(num => {
  //   memo *= num;
  // });

  // return memo;

  return array.reduce((product, current) => product * current, 1);
};

const power = function(a, b) {
	// return a ** b;

  return Math.pow(a, b);
};

const factorial = function(num) {
  let memo = 1;

  for (let i = num; i > 0; i--) {
    memo *= i;
  }

  return memo;
};

// Do not edit below this line
module.exports = {
  add,
  subtract,
  sum,
  multiply,
  power,
  factorial
};
