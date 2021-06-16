# Largest palindrome product
 
# Problem 4
# A palindromic number reads the same both ways. The largest palindrome made 
# from the product of two 2-digit numbers is 9009 = 91 × 99.

# Find the largest palindrome made from the product of two 3-digit numbers.

class Integer
  def palindrome?
    self == self.to_s().split("").reverse().join("").to_i
  end
end

# (1..100).each do |i|
#   puts([i, i.palindrome?])
# end
def largest_palindrome(digits)
  largest = 0
  bottom = 10 ** (digits - 1)
  top = (10 ** digits) - 1
  (bottom..top).each do |i|
    (bottom..top).each do |j|
      product = i * j
      if product.palindrome? and product > largest
        largest = product
      end
    end
  end
  return largest
end

puts(largest_palindrome(2))
# This is a really slow brute force method that takes a couple seconds.
# I should make a faster version later, but it does solve the problem.
puts(largest_palindrome(3))