# frozen_string_literal: true

require_relative "../lib/hash_map"

describe HashMap do
  subject(:hash_map) { HashMap.new(bucket_count: 4) }

  describe "#set(key, value)" do
    context "with a new key" do
      it "adds the new key/value pair" do
        # fix the index position of the new key/value
        allow(hash_map).to receive(:hash).and_return(1)

        hash_map.set("foo", "bar")
        node = hash_map.buckets[1].head

        expect(node.key).to eq("foo")
        expect(node.value).to eq("bar")
      end
    end

    context "with an existing matching key in the target bucket" do
      it "overwrites the old value with the new one for that key" do
        # fix the index position of the new key/value
        allow(hash_map).to receive(:hash).and_return(1)

        hash_map.set("foo", "old value")
        hash_map.set("foo", "new value")

        node = hash_map.buckets[1].head

        expect(node.key).to eq("foo")
        expect(node.value).to eq("new value")
      end
    end

    # Handling collisions
    context "with an existing different key in the target bucket" do
      it "appends the new key/value pair to a linked list inside that bucket" do
        # fix the index position of the new key/value
        allow(hash_map).to receive(:hash).and_return(1)

        hash_map.set("foo", "value for foo")
        hash_map.set("bar", "value for bar")

        list = hash_map.buckets[1]

        expect(list.head.key).to eq("foo")
        expect(list.head.value).to eq("value for foo")
        expect(list.tail.key).to eq("bar")
        expect(list.tail.value).to eq("value for bar")
        expect(list.to_s).to eq("( foo:value for foo ) -> ( bar:value for bar ) -> nil")
      end
    end

    # Increasing the bucket count
    context "when the load_factor is not exceeded" do
      it "does not increase the bucket count" do
        allow(hash_map).to receive(:load_factor_exceeded?).and_return(false)

        expect { hash_map.set("foo", "bar") }.not_to change { hash_map.buckets.count }
      end
    end

    context "when the load_factor is exceeded" do
      it "increases the bucket count" do
        allow(hash_map).to receive(:load_factor_exceeded?).and_return(true)

        original_count = hash_map.buckets.count

        expect { hash_map.set("foo", "bar") }
          .to change { hash_map.buckets.count }
          .from(original_count).to(original_count + original_count)
      end
    end
  end

  describe "#get(key, value)" do
    context "when the key is found" do
      it "returns the value" do
        hash_map.set("foo", "bar")

        expected = "bar"
        actual = hash_map.get("foo")

        expect(actual).to eq(expected)
      end
    end

    context "when the key is not found" do
      it "returns nil" do
        expected = nil
        actual = hash_map.get("foo")

        expect(actual).to eq(expected)
      end
    end

  end

  describe "#has?(key)" do
    context "when the key is found" do
      it "returns true" do
        hash_map.set("foo", "bar")

        expected = true
        actual = hash_map.has?("foo")

        expect(actual).to eq(expected)
      end
    end

    context "when the key is found deeper in the list" do
      it "returns true" do
        allow(hash_map).to receive(:index).and_return(1)
        hash_map.set("foo", "bar")
        hash_map.set("baz", "bif")

        expected = true
        actual = hash_map.has?("baz")

        expect(actual).to eq(expected)
      end
    end

    context "when the key is not found" do
      it "returns false" do
        expected = false
        actual = hash_map.has?("foo")

        expect(actual).to eq(expected)
      end
    end
  end

  describe "#remove(key)" do
    context "when the key exists" do
      it "removes the entry with that key" do
        hash_map.set("foo", "bar")

        expect { hash_map.remove("foo") }
          .to change { hash_map.has?("foo") }
          .from(true).to(false)
      end

      it "returns the deleted entry's value" do
        hash_map.set("foo", "bar")

        expected = "bar"
        actual = hash_map.remove("foo")

        expect(actual).to eq(expected)
      end
    end

    context "when the key does not exist" do
      it "returns nil" do
        expected = nil
        actual = hash_map.remove("foo")

        expect(actual).to eq(expected)
      end
    end
  end

  describe "#length" do
    it "returns the number of stored keys in the hash map" do
      hash_map.set("1", "a")
      hash_map.set("2", "b")
      hash_map.set("3", "c")
      hash_map.set("4", "d")
      hash_map.set("5", "e")

      expected = 5
      actual = hash_map.length

      expect(actual).to eq(expected)
    end
  end

  describe "#clear" do
    it "removes all entries in the hash map" do
      hash_map.set("1", "a")
      hash_map.set("2", "b")
      hash_map.set("3", "c")
      hash_map.set("4", "d")
      hash_map.set("5", "e")

      expect { hash_map.clear }
        .to change { hash_map.length }
        .from(5).to(0)
    end
  end

  describe "#keys" do
    it "returns an array containing all the keys inside the hash map" do
      hash_map.set("1", "a")
      hash_map.set("2", "b")
      hash_map.set("3", "c")
      hash_map.set("4", "d")
      hash_map.set("5", "e")

      expected = ["1", "2", "3", "4", "5"]
      actual = hash_map.keys.sort

      expect(actual).to eq(expected)
    end
  end

  describe "#values" do
    it "returns an array containing all the values inside the hash map" do
      hash_map.set("1", "a")
      hash_map.set("2", "b")
      hash_map.set("3", "c")
      hash_map.set("4", "d")
      hash_map.set("5", "e")

      expected = ["a", "b", "c", "d", "e"]
      actual = hash_map.values.sort

      expect(actual).to eq(expected)
    end
  end

  describe "#values" do
    it "returns an array that contains each key, value pair" do
      # Example: [[first_key, first_value], [second_key, second_value]]
      hash_map.set("1", "a")
      hash_map.set("2", "b")
      hash_map.set("3", "c")
      hash_map.set("4", "d")
      hash_map.set("5", "e")

      expected = [["1", "a"], ["2", "b"], ["3", "c"], ["4", "d"], ["5", "e"]]
      actual = hash_map.entries.sort

      puts hash_map

      expect(actual).to eq(expected)
    end
  end
end
