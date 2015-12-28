require 'simplecov'
SimpleCov.start
require 'minitest'
require 'bloom_filter'

class BloomFilterTest < Minitest::Test
  attr_reader :bloomie

  def setup
    @bloomie = BloomFilter.new
  end

  def test_intitialize
    bloomie = BloomFilter.new(3)
    assert_equal "000", bloomie.binary_vector
  end

  def test_insert
    bloomie.insert("pizza")
    refute_equal 0, bloomie.binary_vector
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
