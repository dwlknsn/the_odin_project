require_relative "../sub_strings"

describe "#substrings" do
  it "returns the substrings for one word" do
    target_string = "below"
    dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]

    expect(substrings(target_string, dictionary)).to eq(
      {
        "below" => 1,
        "low" => 1
      }
    )
  end

  it "returns the substrings for multiple words" do
    target_string = "Howdy partner, sit down! How's it going?"
    dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]

    expect(substrings(target_string, dictionary)).to eq(
      {
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
    )
  end
end
