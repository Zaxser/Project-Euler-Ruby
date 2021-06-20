# Pandigital prime

# Problem 41
# We shall say that an n-digit number is pandigital if it makes use of all the 
# digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is 
# also prime.

# What is the largest n-digit pandigital prime that exists?

class Integer
  # Made on the theory that they'd be faster to generate than to check
  def pandigitals 
    (1..self).to_a.permutation.map do |permutation|
      permutation.map(&:to_s).join("").to_i
    end
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
end

# 8 and 9 digit pandigitals will always be divisible by 9!
all_pandigitals = (1..7).map {|n| n.pandigitals}.inject([], :+)

# In numerical order, so just go through backwards and the first prime you see
# is the largest.
all_pandigitals.reverse_each do |pandigital|
  break p pandigital if pandigital.prime?
end