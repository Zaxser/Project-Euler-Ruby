# 10001st prime

# Problem 7
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

# What is the 10 001st prime number?
require "set"

class Integer
  # This is gnarly; there are prettier ways I could've written this, but they
  # are much slower.
  def primes_below
    return false if self < 1
    return 2 if self == 1
    primes = Set.new([2])
    n = 2 
    until n == self
      n += 1
      prime = false
      primes.each do |p|
        break if n % p == 0
        if p * p > n
          prime = true
          break
        end
      end
      primes << n if prime
    end
    return primes.max
  end
end

puts(6.th_prime)
puts(10_001.th_prime)