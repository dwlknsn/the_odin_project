# odin-ruby-sub-strings

Implement a method #substrings that takes a word as the first argument and then an array of valid substrings (your dictionary) as the second argument. It should return a hash listing each substring (case insensitive) that was found in the original string and how many times it was found.

```
target_string = "below"

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings(target_string, dictionary)
=> {
  "below" => 1,
  "low" => 1
}
```

Next, make sure your method can handle multiple words:

```

target_string = "Howdy partner, sit down! How's it going?"

dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]

substrings(target_string, dictionary)
=> {
  "down" => 1,
  "go" => 1,
  "going" => 1,
  "how" => 2,
  "howdy" => 1,
  "it" => 2,
  "i" => 3,
  "own" => 1,
  "part" => 1,
  "partner" => 1,
  "sit" => 1
}
```
