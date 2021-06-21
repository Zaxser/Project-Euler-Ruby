# Combinatoric selections

# Problem 53
# There are exactly ten ways of selecting three from five, 12345:

# 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345

# In combinatorics, we use the notation, 
# 5 choose 3 = 10.

# In general, 
 
# n choose r = n! / r!(n - r)! , where , r <= n , n! = n * n -1 * ... * 1 and 
# 0! = 1.

# It is not until n = 23, that a value exceeds one-million: 
# 23 choose 10 = 1144066.

# How many, not necessarily distinct, values of n choose r for n choose r for, 
# 1 <= n <= 100 are greater than one-million?

class Integer
  def factorial # assumes positive integers
    return 1 if self == 0
    (1..self).inject(:*)
  end

  def choose(r)
    self.factorial / (r.factorial * (self - r).factorial)
  end
end

p 5.factorial
p 5.choose(3)
p 23.choose(10)

how_many = 0
(1..100).each do |n|
  (1..n).each do |r|
    how_many += 1 if n.choose(r) > 1_000_000
  end
end

p how_many