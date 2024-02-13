const palindromes = function (string) {
    let chars = string.toLowerCase().match(/\w{1}/g);

    let left;
    let right;

    for (let i = 0; i < chars.length; i++) {
        left = chars[i];
        right = chars[chars.length -i -1];

        if (left != right) return false;
    }

    return true;
};

// Do not edit below this line
module.exports = palindromes;
