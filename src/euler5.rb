# Smallest multiple

# Problem 5
# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

# def smallest_multiple(n)
#   multiple = 1
#   n.downto(2) do |i|
#     if multiple % i != 0
#       multiple *= i
#     end
#   end
#   return multiple
# end

def smallest_multiple(n)
  multiple = (1..n).to_a().inject(:*)

  (1..n).each do |i|
    candidate = multiple / i
    n.downto(2) do |j|
      unless candidate % i == 0
        candidate = multiple
        break
      end
    end
    multiple = candidate
  end
  return multiple
end

puts(smallest_multiple(10))
puts(smallest_multiple(20))