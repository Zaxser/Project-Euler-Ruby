# Summation of primes
 
# Problem 10
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

# Find the sum of all the primes below two million.

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
    return primes
  end
end

p 10.primes_below.inject(:+)
p 2_000_000.primes_below.inject(:+)