const fibonacci = function(a) {
  let num = parseInt(a);

  if (num < 0) return 'OOPS';

  let array = [0, 1];

  for (let i = 2; i <= num; i++) {
    array.push(array[array.length -2] + array[array.length -1]);
  }
  return array[num];
};

// Do not edit below this line
module.exports = fibonacci;
