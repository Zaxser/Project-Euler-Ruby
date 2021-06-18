# Power digit sum

# Problem 16
# 215 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

# What is the sum of the digits of the number 21000?

def digit_sum(n)
  n.to_s.split("").map {|digit| digit.to_i}.inject(:+)
end

p digit_sum(2**15)
p digit_sum(2**1000)