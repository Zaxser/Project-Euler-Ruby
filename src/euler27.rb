# Quadratic primes

# Problem 27
# Euler discovered the remarkable quadratic formula:
# n^2 + n + 41

# It turns out that the formula will produce 40 primes for the consecutive 
# integer values 0 < n <= 39. However, when n = 40, 40^2 + 40 + 41 = 
# 40(40 + 1) + 40 is divisible by 41, and certainly when n = 41, 41^2 + 41 + 41
# is clearly divisible by 41.

# The incredible formula n^2 - 79n + 1601 was discovered, which produces 80 
# primes for the consecutive values 0 <= n <= 79. The product of the 
# coefficients, −79 and 1601, is −126479.

# Considering quadratics of the form:

# n^2 + an + b, where |a| < 1000 and |b| <= 1000 

# where |n| is the modulus/absolute value of n
# e.g. where |11| = 11 and |-4| = 4

# Find the product of the coefficients, a and b, for the quadratic expression 
# that produces the maximum number of primes for consecutive values of n, 
# starting with n = 0.

class Integer
  def prime?
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

# Quick Test; Seems to work
# p (1..100).select {|n| n.prime?}

max = 0
coefficient_product = 1

(-999..999).each do |a|
  (-1000..1000).each do |b|
    n = 0
    # Ah. This was the detail that held me back for a bit: make sure that the
    # number is positive before checking for primeness.
    while (n * n + (a * n) + b).abs.prime?
      n += 1
    end
    if n > max
      max = n
      coefficient_product = a * b
      # p [max, a, b]
    end
  end
end

p coefficient_product