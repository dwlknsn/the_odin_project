require_relative "linked_list"

class HashMap
  attr_reader :load_factor, :buckets, :bucket_count

  def initialize(load_factor: 0.75, bucket_count: 16)
    @load_factor = load_factor
    @bucket_count = bucket_count
    @buckets = Array.new(bucket_count) { LinkedList.new }
  end

  def hash(key)
    # hash(key) takes a key and produces a hash code with it.

    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def index(key)
    i = hash(key) % buckets.length

    raise IndexError if i.negative? || i >= buckets.length

    i
  end

  def set(key, value)
    # set(key, value) takes two arguments, the first is a key and the
    # second is a value that is assigned to this key.

    list = buckets[index(key)]
    list.remove_at(list.find(key)) if list.contains?(key)
    list.append(key, value)

    increase_bucket_count if load_factor_exceeded?
  end

  def get(key)
    # get(key) takes one argument as a key and returns the
    # value that is assigned to this key. If key is not found, return nil.

    list = buckets[index(key)]
    if list.contains?(key)
      list.at(list.find(key)).value
    end
  end

  def has?(key)
    buckets.any? { |bucket| bucket.contains?(key) }
  end

  def remove(key)
    list = buckets.find { |bucket| bucket.contains?(key) }

    return unless list
    return unless list.contains?(key)

    i = list.find(key)
    value = list.at(i).value
    list.remove_at(i)

    value
  end

  def length
    buckets.sum { |bucket| bucket.size }
  end

  def clear
    buckets.each(&:empty!)
  end

  def keys
    buckets.each_with_object([]) do |bucket, arr|
      arr.concat(bucket.keys)
    end
  end

  def values
    buckets.each_with_object([]) do |bucket, arr|
      arr.concat(bucket.values)
    end
  end

  def entries
    buckets.each_with_object([]) do |bucket, arr|
      arr.concat(bucket.entries)
    end
  end

  def to_s
    buckets.each { |b| puts b }
  end

  private

  def increase_bucket_count
    old_buckets = buckets
    new_buckets = Array.new(bucket_count) { LinkedList.new }
    @buckets = old_buckets.concat(new_buckets)
  end

  def load_factor_exceeded?
    buckets.count(&:empty?) > load_factor * bucket_count
  end
end
