# Circular primes
 
# Problem 35
# The number, 197, is called a circular prime because all rotations of the 
# digits: 197, 971, and 719, are themselves prime.

# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71,
# 73, 79, and 97.

# How many circular primes are there below one million?

require "set"

class Integer
  def digits
    self.to_s.split("").map(&:to_i)
  end

  def rotate
    (self.to_s[-1] + self.to_s[0...-1]).to_i
  end

  def rotations
    rotations = [self]
    (digits.length - 1).times {rotations << rotations[-1].rotate}
    rotations
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

  def circular_prime?
    self.rotations.all?(&:prime?)
  end
end

# Quick Tests
p 197.rotate
p 197.rotations
p 197.circular_prime?
p 196.circular_prime?

p under_100 = (1..100).select(&:circular_prime?)
p under_100.length
p under_1_million = (1..1_000_000).select(&:circular_prime?)
p under_1_million.length #55 in 55 long program; nice synchronicity