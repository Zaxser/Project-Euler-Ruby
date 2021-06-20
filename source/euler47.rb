# Distinct primes factors

# Problem 47
# The first two consecutive numbers to have two distinct prime factors are:

# 14 = 2 × 7
# 15 = 3 × 5

# The first three consecutive numbers to have three distinct prime factors are:

# 644 = 2² × 7 × 23
# 645 = 3 × 5 × 43
# 646 = 2 × 17 × 19.

# Find the first four consecutive integers to have four distinct prime factors 
# each. What is the first of these numbers?

require "set"

class Integer
  def distinct_prime_factors
    n = self
    factors = Set.new()
    
    while n % 2 == 0
      n /= 2
      factors << 2
    end
    
    i = 3
    
    while n != 1
      while n % i == 0
        n /= i
        factors << i
      end
      i += 2
    end

    factors
  end
end

# Quick Tests; Seem great
p 14.distinct_prime_factors
p 15.distinct_prime_factors
p 644.distinct_prime_factors
p 645.distinct_prime_factors
p 646.distinct_prime_factors

# I wonder if there's some better wayt do this with analysis
def first_n_with_n_factors(n)
  consecutive = []
  
  i = 2 # 1 isn't prime, so it doesn't have prime factors
  while consecutive.length < n
    consecutive << i if i.distinct_prime_factors.length == n
    consecutive = [] if i.distinct_prime_factors.length != n
    i += 1
  end

  consecutive
end

# Quick Tests; Seem Great
p first_n_with_n_factors(2)
p first_n_with_n_factors(3)

# Little Slow; Still done in less than a minute, but I should probably figure
# out a way to do this more efficiently
p first_n_with_n_factors(4)