require 'pry'
require 'digest'

class BloomFilter
  attr_reader :binary_vector, :set, :size

  def initialize(size = 10)
    @size = size
    @set = 0
  end

  def insert(key)
    digesters(key).each do |index|
      @set = set | ("1" + "0"*(index)).to_i(2)
    end
  end

  def in_set?(key)
    digesters(key).map do |index|
      set & (("1" + "0"*(index)).to_i(2))
    end.all?{ |bool| bool != 0}
  end

  def digesters(key)
    d1 = digest_md5(key) % size
    d2 = digest_SHA1(key) % size
    d3 = digest_SHA2(key) % size
    [d1, d2, d3]
  end

  def digest_md5(key)
    Digest::MD5.hexdigest(key).to_i(16)
  end

  def digest_SHA1(key)
    Digest::SHA1.hexdigest(key).to_i(16)
  end

  def digest_SHA2(key)
    Digest::SHA2.hexdigest(key).to_i(16)
  end

end
