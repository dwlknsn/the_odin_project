require_relative "../stock_picker"

describe "stock_picker" do
  it "works with the provided example" do
    prices = [17, 3, 6, 9, 15, 8, 6, 1, 10]

    expect(stock_picker(prices)).to eq([1, 4])
  end

  it "returns the first and last indexes when the price increases every day" do
    prices = [2, 4, 6, 8, 10, 12, 14, 16]

    expect(stock_picker(prices)).to eq([0, 7])
  end

  it "returns [0, 0] if the price decreases every day" do
    prices = [17, 15, 13, 11, 9, 7]

    expect(stock_picker(prices)).to eq([0, 0])
  end
end
