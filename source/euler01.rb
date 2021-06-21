# Multiples of 3 and 5

# Problem 1
# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

# Find the sum of all the multiples of 3 or 5 below 1000.

def euler1(n)
  result = 0
  (1...n).each do |n|
    result += n if n % 3 == 0 or n % 5 == 0
  end
  return result
end

puts(euler1(10)) # Should be 23

# solution
puts(euler1(1000))