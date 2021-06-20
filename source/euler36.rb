# Double-base palindromes

# Problem 36
# The decimal number, 585 = 1001001001 (binary), is palindromic in both bases.

# Find the sum of all numbers, less than one million, which are palindromic in 
# base 10 and base 2.

# (Please note that the palindromic number, in either base, may not include 
# leading zeros.)

# Should probably roll my own binary converter some day (for fun), but as it is,
# this is really trivial.

class String
  def palindrome?
    self == self.reverse
  end
end

class Integer
  def palindrome?(base = 10)
    self.to_s(base).palindrome?
  end
end

# Quick Test
p 585.palindrome? and 585.palindrome?(2)
.
p (1..1_000_000).select {|n| n.palindrome? and n.palindrome?(2)}.inject(:+)