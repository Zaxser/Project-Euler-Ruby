# Digit fifth powers

# Problem 30
# Surprisingly there are only three numbers that can be written as the sum of 
# fourth powers of their digits:

# 1634 = 14 + 64 + 34 + 44
# 8208 = 84 + 24 + 04 + 84
# 9474 = 94 + 44 + 74 + 44
# As 1 = 14 is not a sum it is not included.

# The sum of these numbers is 1634 + 8208 + 9474 = 19316.

# Find the sum of all the numbers that can be written as the sum of fifth 
# powers of their digits.

def digit_powers(power)
  sums = []
  # First I was wrong because I assumed they all had to be five digits; then I
  # was wrong becaus the assumption is that 1 doesn't count, maybe because
  # valid sums are two digits.
  (10...10**7).each do |candidate|
    digits = candidate.to_s.split("").map(&:to_i)
    sum = digits.map {|digit| digit**power}.inject(:+)
    sums << candidate if candidate == sum
  end
  sums
end

p dp = digit_powers(5)
p dp.inject(:+)