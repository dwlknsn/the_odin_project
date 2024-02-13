require_relative "../caesar_cipher"

describe "#caesar_cipher" do
  it "works with a small positive shift value" do
    expect(caesar_cipher("string", 1)).to eq("tusjoh")
  end

  it "works with a small negative shift value" do
    expect(caesar_cipher("string", -1)).to eq("rsqhmf")
  end

  it "works with a large positive shift value" do
    expect(caesar_cipher("string", 20)).to eq("mnlcha")
  end

  it "works with a large negative shift value" do
    expect(caesar_cipher("string", -20)).to eq("yzxotm")
  end

  it "returns the original string when shift value is 0" do
    expect(caesar_cipher("string", 0)).to eq("string")
  end

  it "returns the original string when shift value is 26" do
    expect(caesar_cipher("string", 26)).to eq("string")
  end

  it "returns the original string when shift value is a multiple of 26" do
    expect(caesar_cipher("string", 260)).to eq("string")
  end

  it "returns the original string when shift value is -26" do
    expect(caesar_cipher("string", 0)).to eq("string")
  end

  it "maintains the original upper case and lower case" do
    expect(caesar_cipher("StRiNg", 1)).to eq("TuSjOh")
  end

  it "loops around the end of the alphabet correctly with a positive shift value" do
    expect(caesar_cipher("xyzXYZ", 3)).to eq("abcABC")
  end

  it "loops around the end of the alphabet correctly with a negative shift value" do
    expect(caesar_cipher("abcABC", -3)).to eq("xyzXYZ")
  end

  it "maintains the original punctuation" do
    expect(caesar_cipher("!@#$%^&*(),./?><';\":\\][]|}{}`~   ", -3)).to eq("!@#$%^&*(),./?><';\":\\][]|}{}`~   ")
  end

  it "maintains numbers" do
    expect(caesar_cipher("1234567890", -3)).to eq("1234567890")
  end

  it "works with multiple words" do
    expect(caesar_cipher("Hello, World! This is an example of a caesar cipher!", 1)).to eq("Ifmmp, Xpsme! Uijt jt bo fybnqmf pg b dbftbs djqifs!")
  end
end
