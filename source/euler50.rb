# Consecutive prime sum

# Problem 50
# The prime 41, can be written as the sum of six consecutive primes:

# 41 = 2 + 3 + 5 + 7 + 11 + 13
# This is the longest sum of consecutive primes that adds to a prime below 
# one-hundred.

# The longest sum of consecutive primes below one-thousand that adds to a 
# prime, contains 21 terms, and is equal to 953.

# Which prime, below one-million, can be written as the sum of the most 
# consecutive primes?

class Integer
  def prime? # Assumes positive integers
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
end


# Eh, this was a bit of a stretch for a monkey patch, even for me
def longest_consecutive_prime_under(max)
  primes = (1..max).select {|n| n.prime?}

  length = 1
  candidate = 2
  while length < (primes.length / 2)
    index = 0
    sum = primes[index..length].inject(:+)
    until primes.include?(sum) or sum > max or index + length > primes.length / 2
      index += 1
      sum = primes[index..(index + length)].inject(:+)
    end
    if primes.include?(sum) and sum < max
      # p primes[index..(index + length)]
      candidate = sum 
    end
    length += 1
  end
  candidate
end

# Tests
p longest_consecutive_prime_under(100)
p longest_consecutive_prime_under(1_000)
# This is really slow; (more than a minute?); Should develop a faster version
# eventually.
p longest_consecutive_prime_under(1_000_000)