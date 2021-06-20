# Pandigital products

# Problem 32
# We shall say that an n-digit number is pandigital if it makes use of all the 
# digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 
# through 5 pandigital.

# The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing 
# multiplicand, multiplier, and product is 1 through 9 pandigital.

# Find the sum of all products whose multiplicand/multiplier/product identity 
# can be written as a 1 through 9 pandigital.

# HINT: Some products can be obtained in more than one way so be sure to only 
# include it once in your sum.

# Direct; Really slow even on my computer; Maybe not the correct way to do
# this? (Finishes in less than a minute at 2,000, but seems to never finish at
# 10,000.)

require "set"
pandigit_products = SortedSet.new()

(1..2000).each do |multiplicand|
  (multiplicand..2000).each do |multiplier|
    product = multiplicand * multiplier
    digits = (product.to_s + multiplicand.to_s + multiplier.to_s).split("").sort
    # p digits
    pandigit_products << product if digits.join("") == "123456789" # pandigital?
  end
end 

p pandigit_products
p pandigit_products.inject(:+)