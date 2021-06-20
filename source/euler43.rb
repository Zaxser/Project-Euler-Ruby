# Sub-string divisibility

# Problem 43
# The number, 1406357289, is a 0 to 9 pandigital number because it is made up 
# of each of the digits 0 to 9 in some order, but it also has a rather 
# interesting sub-string divisibility property.

# Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note 
# the following:

# d2d3d4=406 is divisible by 2
# d3d4d5=063 is divisible by 3
# d4d5d6=635 is divisible by 5
# d5d6d7=357 is divisible by 7
# d6d7d8=572 is divisible by 11
# d7d8d9=728 is divisible by 13
# d8d9d10=289 is divisible by 17
# Find the sum of all 0 to 9 pandigital numbers with this property.

# Very direct and obvious way of going about this, but it's a tad slow. Should
# probably think of a faster way to do this eventually.

def substring_divisibity(pandigital)
  return false if pandigital[1..3].to_i % 2 != 0
  return false if pandigital[2..4].to_i % 3 != 0
  return false if pandigital[3..5].to_i % 5 != 0
  return false if pandigital[4..6].to_i % 7 != 0
  return false if pandigital[5..7].to_i % 11 != 0
  return false if pandigital[6..8].to_i % 13 != 0
  return false if pandigital[7..9].to_i % 17 != 0
  true
end

p substring_divisibity(1406357289.to_s)

pandigitals = (0..9).to_a.permutation.reject do |permuatation|
  permuatation[0] == 0
end
pandigitals = pandigitals.map do |permutation|
  permutation.map(&:to_s).join("")
end

pandigitals = pandigitals.select {|pandigi| substring_divisibity(pandigi)}

p pandigitals.map(&:to_i).inject(:+)