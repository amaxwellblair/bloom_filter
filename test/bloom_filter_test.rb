require 'simplecov'
SimpleCov.start
require 'minitest'
require 'bloom_filter'
require 'digest'

class BloomFilterTest < Minitest::Test
  attr_reader :bloomie

  def setup
    args = {digests: [Digest::MD5, Digest::SHA1, Digest::SHA2]}
    @bloomie = BloomFilter.new(args)
  end

  def test_intitialize
    bloomie = BloomFilter.new
    assert_equal 0, bloomie.bit_vector
  end

  def test_intitialize_size
    bloomie = BloomFilter.new({size: 100})
    assert_equal 100, bloomie.size
  end

  def test_insert
    bloomie.insert("pizza")
    refute_equal 0, bloomie.bit_vector
  end

  def test_in_set_true
    bloomie.insert("pizza")
    assert_equal true, bloomie.in_set?("pizza")
  end

  def test_in_set_false
    bloomie.insert("pizza")
    assert_equal false, bloomie.in_set?("croissant")
  end


end
