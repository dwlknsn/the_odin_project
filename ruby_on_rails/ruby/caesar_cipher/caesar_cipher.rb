# In cryptography, a Caesar cipher, also known as Caesar’s cipher, the shift cipher, Caesar’s code or Caesar shift, is one of the simplest and most widely known encryption techniques. It is a type of substitution cipher in which each letter in the plaintext is replaced by a letter some fixed number of positions down the alphabet. For example, with a left shift of 3, D would be replaced by A, E would become B, and so on. The method is named after Julius Caesar, who used it in his private correspondence.

UPPERCASE_LOWER_BOUND = 65 # "A".ord => 65
LOWERCASE_LOWER_BOUND = 97 # "a".ord => 97

def caesar_cipher(string, shift_count = 5)
  string.chars.map do |char|
    if char.match?(/[A-Z]/)
      (((char.ord + shift_count - UPPERCASE_LOWER_BOUND) % 26) + UPPERCASE_LOWER_BOUND).chr
    elsif char.match?(/[a-z]/)
      (((char.ord + shift_count - LOWERCASE_LOWER_BOUND) % 26) + LOWERCASE_LOWER_BOUND).chr
    else
      char
    end
  end.join
end
