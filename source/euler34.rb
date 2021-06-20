# Digit factorials

# Problem 34
# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

# Find the sum of all numbers which are equal to the sum of the factorial of 
# their digits.

# Note: As 1! = 1 and 2! = 2 are not sums they are not included.
require "set"

class Integer
  def factorial
    return 1 if self == 0
    (1..self).inject(:*)
  end

  def digits
    self.to_s.split("").map(&:to_i)
  end

  def digit_factorials
    self.digits.map(&:factorial)
  end
end

# Quick Tests
p 0.factorial
p 145.digit_factorials

sums = SortedSet.new()
(10..1_000_000).each do |n|
  sums << n if n.digit_factorials.inject(:+) == n
end

p sums.inject(:+)