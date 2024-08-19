# frozen_string_literal: true

require_relative "../lib/linked_list.rb"

RSpec.describe LinkedList do
  subject(:list) { LinkedList.new }

  describe "#append" do
    context "when called once" do
      it "adds a single Node to the end of the list" do
        list.append("dog")

        expected = "( dog ) -> nil"
        actual = list.to_s

        expect(actual).to eq(expected)
        expect(list.head.next_node).to be_nil
      end
    end

    context "when called multiple times" do
      it "adds the new Nodes to the end of the list in order" do
        list.append("dog")
        list.append("cat")
        list.append("parrot")

        expected = "( dog ) -> ( cat ) -> ( parrot ) -> nil"
        actual = list.to_s

        expect(actual).to eq(expected)
        expect(list.head.next_node).to be_a(Node)
      end
    end
  end

  describe "#prepend" do
    context "when called once" do
      it "adds a single Node to the start of the list" do
        list.prepend("turtle")

        expected = "( turtle ) -> nil"
        actual = list.to_s

        expect(actual).to eq(expected)
        expect(list.head.next_node).to be_nil
      end
    end

    context "when called multiple times" do
      it "adds the new Nodes to the start of the list in order" do
        list.prepend("dog")
        list.prepend("snake")
        list.prepend("turtle")

        expected = "( turtle ) -> ( snake ) -> ( dog ) -> nil"
        actual = list.to_s

        expect(actual).to eq(expected)
      end
    end
  end

  describe "#size" do
    context "when called on an empty list" do
      it "returns zero" do
        expected = 0
        actual = list.size

        expect(actual).to eq(expected)
      end
    end

    context "when called on a populated list" do
      it "returns the correct size" do
        list.append("dog")
        list.append("snake")
        list.append("turtle")

        expected = 3
        actual = list.size

        expect(actual).to eq(expected)
      end
    end
  end

  describe "#head" do
    context "when called on an empty list" do
      it "returns nil" do
        expected = nil
        actual = list.head

        expect(actual).to eq(expected)
      end
    end

    context "when called on a populated list" do
      it "returns the first Node" do
        list.append("dog")
        list.append("snake")
        list.append("turtle")

        expected = "dog"
        actual = list.head.value

        expect(actual).to eq(expected)
        expect(list.head).to be_a(Node)
      end
    end
  end

  describe "#tail" do
    context "when called on an empty list" do
      it "returns nil" do
        expected = nil
        actual = list.tail

        expect(actual).to eq(expected)
      end
    end

    context "when called on a populated list" do
      it "returns the last Node" do
        list.append("dog")
        list.append("snake")
        list.append("turtle")

        expected = "turtle"
        actual = list.tail.value

        expect(actual).to eq(expected)
        expect(list.tail).to be_a(Node)
      end
    end
  end

  describe "#at(index)" do
    context "when called on an empty list" do
      it "returns nil" do
        expected = nil
        actual = list.at(0)

        expect(actual).to eq(expected)
      end
    end

    context "when called on a populated list" do
      it "returns the Node at the target index" do
        list.append("dog")
        list.append("snake")
        list.append("turtle")

        expected = "snake"
        actual = list.at(1).value

        expect(actual).to eq(expected)
      end
    end

    context "when the target index exceeds the length of the list" do
      it "returns nil" do
        list.append("dog")

        expected = nil
        actual = list.at(1)

        expect(actual).to eq(expected)
      end
    end
  end

  describe "#pop" do
    context "when called on an empty list" do
      it "returns nil" do
        expected = nil
        actual = list.pop

        expect(actual).to eq(expected)

        expected = nil
        actual = list.to_s
        expect(actual).to eq(expected)
      end
    end

    context "when called on a populated list" do
      it "removes the final element from the list" do
        list.append("dog")
        list.append("snake")
        list.append("turtle")
        list.pop

        expected = "( dog ) -> ( snake ) -> nil"
        actual = list.to_s

        expect(actual).to eq(expected)
      end
    end
  end

  describe "#contains?(value)" do
    context "when called on an empty list" do
      it "returns false" do
        expected = false
        actual = list.contains?("foo")

        expect(actual).to eq(expected)
      end
    end

    context "when called on a populated list" do
      context "when called with a good value" do
        it "returns true" do
          list.append("dog")
          list.append("snake")
          list.append("turtle")

          expected = true
          actual = list.contains?("turtle")

          expect(actual).to eq(expected)
        end
      end

      context "when called with a bad value" do
        it "returns false" do
          list.append("dog")
          list.append("snake")
          list.append("turtle")

          expected = false
          actual = list.contains?("foo")

          expect(actual).to eq(expected)
        end
      end
    end
  end

  describe "#find(value)" do
    context "when called on an empty list" do
      it "returns nil" do
        expected = nil
        actual = list.find("foo")

        expect(actual).to eq(expected)
      end
    end

    context "when called on a populated list" do
      context "when the list contains the value" do
        it "returns the index of the target value" do
          list.append("dog")
          list.append("snake")
          list.append("turtle")

          expected = 1
          actual = list.find("snake")

          expect(actual).to eq(expected)
        end
      end

      context "when the list does not contain the value" do
        it "returns nil" do
          list.append("dog")
          list.append("snake")
          list.append("turtle")

          expected = nil
          actual = list.find("foo")

          expect(actual).to eq(expected)
        end
      end
    end
  end

  describe "#insert_at(value, index)" do
    context "when called on an empty list" do
      it "inserts the new node when the target index is zero" do
        list.insert_at("WARTHOG", 0)

        expected = "( WARTHOG ) -> nil"
        actual = list.to_s

        expect(actual).to eq(expected)
      end

      it "does not insert the new node when the target index is not zero" do
        list.insert_at("WARTHOG", 1)

        expected = nil
        actual = list.to_s

        expect(actual).to eq(expected)
      end
    end

    context "when called on a populated list" do
      context "when the target_index is within the list" do
        it "inserts the new node at the target index" do
          list.append("dog")
          list.append("snake")
          list.append("turtle")
          list.insert_at("WARTHOG", 1)

          expected = "( dog ) -> ( WARTHOG ) -> ( snake ) -> ( turtle ) -> nil"
          actual = list.to_s

          expect(actual).to eq(expected)
        end
      end

      context "when the target index is outside the length of the list" do
        it "does not insert the new node" do
          list.append("dog")
          list.append("snake")
          list.append("turtle")
          list.insert_at("WARTHOG", 9)

          expected = "( dog ) -> ( snake ) -> ( turtle ) -> nil"
          actual = list.to_s

          expect(actual).to eq(expected)
        end
      end
    end
  end

  describe "#remove_at(index)" do
    context "when called on an empty list" do
      it "returns nil" do
        list.remove_at(1)

        expected = nil
        actual = list.to_s

        expect(actual).to eq(expected)
      end
    end

    context "when called on a populated list" do
      context "when the target_index is within the list" do
        it "removes the node at the target index" do
          list.append("dog")
          list.append("snake")
          list.append("turtle")
          list.remove_at(1)

          expected = "( dog ) -> ( turtle ) -> nil"
          actual = list.to_s

          expect(actual).to eq(expected)
        end
      end

      context "when the target index is outside the length of the list" do
        it "does not remove any node" do
          list.append("dog")
          list.append("snake")
          list.append("turtle")
          list.remove_at(9)

          expected = "( dog ) -> ( snake ) -> ( turtle ) -> nil"
          actual = list.to_s

          expect(actual).to eq(expected)
        end
      end
    end
  end
end
