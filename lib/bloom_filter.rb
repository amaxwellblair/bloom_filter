require 'pry'
require 'digest'

class BloomFilter
  attr_reader :binary_vector

  def initialize(size = 10)
    @binary_vector = '' + "0"*size
  end

  def insert(key)
    d1 = digest_md5(key) % binary_vector.length
    d2 = digest_SHA1(key) % binary_vector.length
    d3 = digest_SHA2(key) % binary_vector.length

    binary_vector[d1] = 1.to_s
    binary_vector[d2] = 1.to_s
    binary_vector[d3] = 1.to_s
  end

  def in_set?(key)
    d1 = digest_md5(key) % binary_vector.length
    d2 = digest_SHA1(key) % binary_vector.length
    d3 = digest_SHA2(key) % binary_vector.length

    [binary_vector[d1], binary_vector[d2], binary_vector[d3]].all? do |bool|
      bool == "1"
    end
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
