# Sum square difference

# Problem 6
# The sum of the squares of the first ten natural numbers is,

## 1**2 + 2**2 +... + 10**2 = 385

# The square of the sum of the first ten natural numbers is,

## (1 + 2 + ... + 10)**2 = 55**2 = 3025

# Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is .

## 3025 - 385 = 2640

# Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

def sum_of_squares(n)
  return (1..n).map {|i| i**2}.inject(:+)
end

puts(sum_of_squares(10)) # Small test; should return 385

def square_of_sum(n)
  return (1..n).inject(:+)**2
end

puts(square_of_sum(10)) # Small test; should return 3025

def square_difference(n)
  return square_of_sum(n) - sum_of_squares(n)
end

puts(square_difference(10)) # Small test; should return 2640

puts(square_difference(100))