# Square root convergents

# Problem 57
# It is possible to show that the square root of two can be expressed as an 
# infinite continued fraction.

# Math.sqrt(2) = 1 + 1/(2 + 1/(2 + 1/(2 + 1/..))) 

# By expanding this for the first four iterations, we get:

#  1 + 1/2 = 3/2 = 1.5
#  1 + 1/(2 + 1/2) = 7/5 = 1.4
#  1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 141666...
#  1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.141379...

# The next three expansions are 99/70, 239/169 , and 577/408 , but the eighth 
# expansion, 1393/985, is the first example where the number of digits in the 
# numerator exceeds the number of digits in the denominator.

# In the first one-thousand expansions, how many fractions contain a numerator 
# with more digits than the denominator?

class Integer
  def prime_factors
    n = self
    factors = []
    while n % 2 == 0
      n /= 2
      factors << 2
    end
    i = 3
    until n == 1
      while n % i == 0
        n /= i
        factors << i
      end
    end
    factors
  end

  def lcm(other) # Lowest Common Multiple
    n = self * other
    n /= 2 while n % 2 == 0 and (n / 2) % self == 0 and (n / 2) % other == 0
    i = 3
    while i < n
      n /= i while n % i == 0 and (n / i) % self == 0 and (n / i) % other == 0
      i += 1
    end
    n
  end

  def to_fraction
    Fraction.new(self, 1)
  end
end

# Quick Tests
# p 2.lcm(3)
# p 6.lcm(3)
# p 3.lcm(6)
# p 25.lcm(8)
# p 35.lcm(10)
# p 10.lcm(35)

class Fraction
  attr_accessor :numerator, :denominator
  
  def initialize(numerator, denominator)
    self.numerator = numerator
    self.denominator = denominator
  end

  def simplify
    top, bottom = self.numerator, self.denominator
    lcm = top.lcm(bottom)
    self.class.new(top / lcm, bottom / lcm)
  end

  def ==(other)
    a, b = self.simplify, other.simplify
    a.numerator == b.numerator and a.denominator == b.denominator
  end

  def *(other)
    self.class.new(self.numerator * other.numerator, 
                  self.denominator * other.denominator)
  end

  def /(other)
    self.class.new(self.numerator * other.denominator,
                  self.denominator * other.numerator)
  end

  def like_term(other)
    other = other.to_fraction if other.is_a?(Integer) # Handle Integers
    self.denominator.lcm(other.denominator)
  end
  
  def +(other)
    lcm = like_term(other)
    numerator = self.numerator * (lcm / self.denominator) +
                other.numerator * (lcm / other.denominator)
    self.class.new(numerator, lcm)
  end

  def -@
    self.class.new(-self.numerator, self.denominator)
  end

  def -(other)
    self + -other
  end
end

# # These all work, but I'm not sure how I'm going to iterate through them; even
# # writing these out is really confusing.
# # On second thought, I think there should be a reasonable way to do this with
# # recursion
# #  1 + 1/2 = 3/2 = 1.5
# p 1.to_fraction + Fraction.new(1, 2)
# #  1 + 1/(2 + 1/2) = 7/5 = 1.4
# # Lisp style indentation, because it's getting long and confusing.
# p  1.to_fraction + (
#     1.to_fraction / (
#       2.to_fraction + Fraction.new(1, 2)
#     )
#   )
# #  1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 141666...
# p   1.to_fraction + (
#       1.to_fraction / (
#         2.to_fraction + (
#           1.to_fraction / (
#             2.to_fraction + Fraction.new(1, 2)
#           )
#         )
#       )
#     )
# #  1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.141379...
# p   1.to_fraction + (
#       1.to_fraction / (
#         2.to_fraction + (
#           1.to_fraction / (
#             2.to_fraction + (
#               1.to_fraction / (
#                 2.to_fraction + Fraction.new(1,2)
#               )
#             )
#           )
#         )
#       )
#     )

# 1 +
# 1 + (1/ 2)
# 1 + (1/ (2 + 1/ 2))
def fraction_square_2(depth, top = true)
  return 1.to_fraction + (1.to_fraction / fraction_square_2(depth - 1, false)) if top
  return 2.to_fraction if depth == 0
  return 2.to_fraction + (1.to_fraction/ fraction_square_2(depth - 1, false))
end

# # Alright, let's see how this goes.
# #  1 + 1/2 = 3/2 = 1.5
# p fraction_square_2(1)

# #  1 + 1/(2 + 1/2) = 7/5 = 1.4
# p fraction_square_2(2)

# #  1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 141666...
# p fraction_square_2(3)

# #  1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.141379...
# p fraction_square_2(4)

# # The next three expansions are 99/70, 239/169 , and 577/408 , but the eighth 
# # expansion, 1393/985
# p fraction_square_2(5)
# p fraction_square_2(6)
# p fraction_square_2(7)
# p fraction_square_2(8)

# Eek; this starts getting really slow even at 20.
# answer = (1..1000).count do |n|
#   p n
#   f = fraction_square_2(n)
#   f.numerator.to_s.length > f.denominator.to_s.length
# end

# p answer

# I think that this was all very interesting and everything, but it may be the
# time to apply some analysis. We have a... not a function in the mathematical
# sense, but a thing that returns multiple values.

# SCRAPPED - Prime Sequence Analysis
# There's 1 prime between 3 and 7 (5), 2 between 7 and 17 (11, 13) and 
# (19, 23, 29, 31, 37)
# It was nice while it lasted.

# Fruitful Sequence Analysis
# 1 => (3, 2)
# 2 => (7, 5)
# 3 => (17, 12)
# 4 => (41, 29)
# 7 = 3 * 2 + 1; 17 = 7 * 2 + 3; 41  = 17 * 2 + 7;
# 3, 7 are the numerators, so if 5 is 41 * 2 + 17, we may have an exploitable
# pattern.
# 5=> (99, 70), 99 = 41 * 2 + 17. We have a pattern.
# The same pattern is present, for the denominator:
# 5 = 2 * 2 + 1; 12 = 5 * 2 + 2; 19 = 12 * 12 + 5
# This is actually really interesting. The self referential nature of the 
# sequence makes me wonder if this is related to the fibonacci sequence.

def square_root_2_sequence(n)
  seed = [[1, 1], [3, 2]]
  (n - 1).times do |n|
    seed << [seed[-1][0] * 2 + seed[-2][0], seed[-1][1] * 2 + seed[-2][1]]
  end
  seed[1..]
end

# Looks good
p square_root_2_sequence(5)

# It's big, so it takes a second or two to print, but the speed is fine.
sequence = square_root_2_sequence(1000)

p sequence.count {|fraction| fraction[0].to_s.length > fraction[1].to_s.length}