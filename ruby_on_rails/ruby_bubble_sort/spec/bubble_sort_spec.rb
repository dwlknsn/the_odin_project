require_relative "../bubble_sort"

describe "bubble_sort" do
  it "sorts the provided example" do
    expect(bubble_sort([4, 3, 78, 2, 0, 2])).to eq([0, 2, 2, 3, 4, 78])
  end

  it "sorts a small array" do
    expect(bubble_sort([3, 2, 1])).to eq([1, 2, 3])
  end

  it "sorts a large array" do
    expect(bubble_sort(50.downto(1).to_a)).to eq(1.upto(50).to_a)
  end

  it "works with an array that's already sorted" do
    expect(bubble_sort([1, 2, 3, 4, 5])).to eq([1, 2, 3, 4, 5])
  end

  it "works with negative numbers" do
    expect(bubble_sort([-1, -2, -3, -4, -5])).to eq([-5, -4, -3, -2, -1])
  end
end
