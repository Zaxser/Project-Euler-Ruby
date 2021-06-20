# Champernowne's constant

# Problem 40
# An irrational decimal fraction is created by concatenating the positive 
# integers:

# 0.123456789101112131415161718192021...

# It can be seen that the 12th digit of the fractional part is 1.

# If dn represents the nth digit of the fractional part, find the value of the 
# following expression.

# d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000

# Really slow, sort of dumb way to do this; should really make a more efficient
# version at some point.

d = ""
value = 0 # starting with zero to avoid off-by-one errors
until d.length > 1000000
  d += value.to_s
  value += 1
end

d = d.split("").map(&:to_i)

p d[1] * d[10] * d[100] * d[1000] * d[10000] * d[100000] * d[1000000]