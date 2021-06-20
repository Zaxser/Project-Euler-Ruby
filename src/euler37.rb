# Truncatable primes
# Submit

#  Show HTML problem content 
# Problem 37
# The number 3797 has an interesting property. Being prime itself, it is 
# possible to continuously remove digits from left to right, and remain prime 
# at each stage: 3797, 797, 97, and 7. Similarly we can work from right to 
# left: 3797, 379, 37, and 3.

# Find the sum of the only eleven primes that are both truncatable from left to 
# right and right to left.

# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

require "set"

class Integer
  def left_truncations
    self.to_s.length.times.map {|n| self.to_s[n..].to_i}
  end

  def right_truncations
    self.to_s.length.times.map {|n| self.to_s[0..n].to_i}
  end

  def truncations
    SortedSet.new(self.left_truncations + self.right_truncations)
  end

  def prime?
    return false if self == 1 # 1 isn't prime
    return true if self == 2
    return false if self % 2 == 0
    i = 3
    until i * i > self
      return false if self % i == 0
      i += 2
    end
    return true
  end

  def truncated_prime?
    self.truncations.all?(&:prime?)
  end
end

p 3797.left_truncations
p 3797.right_truncations
p 3797.truncations
p 3797.truncated_prime?

# This takes a few seconds; one of these days I'll have to start taking
# efficiency seriously.
p truncated_primes = (10...1_000_000).select(&:truncated_prime?)
p truncated_primes.inject(:+)