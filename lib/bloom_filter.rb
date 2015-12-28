require 'pry'

class BloomFilter
  attr_reader :bit_vector, :size, :digests, :test_mode

  def initialize(args = {})
    @size = args.fetch(:size, 10)
    @bit_vector = 0
    @digests = args[:digests]
    @test_mode = args.fetch(:test, false)
  end

  def insert(key)
    digesters(key).each do |index|
      @bit_vector = bit_vector | 2**(index)
    end
  end

  def in_set?(key)
    digesters(key).each do |index|
      return false if (bit_vector & 2**(index)) == 0
    end
    true
  end

  def digesters(key)
    digests.map do |digest|
      digest.hexdigest(key).to_i(16) % size
    end
  end

end
#
# module FalsePositive
#   attr_reader :actual_keys, :false_positives
#
#   def initialize
#     @actual_keys  = []
#     @false_positives = 0
#   end
#
#   def keys_insert(key)
#     actual_keys << key
#   end
#
#   def false_positives_counter(key)
#     if !actual_keys.any?{ |actual| actual == key}
#       @false_positives += 1
#     end
#   end
#
# end
