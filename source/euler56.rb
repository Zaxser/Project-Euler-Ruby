# Powerful digit sum

# Problem 56
# A googol (10^100) is a massive number: one followed by one-hundred zeros; 
# 100^100 is almost unimaginably large: one followed by two-hundred zeros. 
# Despite their size, the sum of the digits in each number is only 1.

# Considering natural numbers of the form, a^b, where a, b < 100, what is the 
# maximum digital sum?

class Integer
  def digit_sum
    self.to_s.split("").map(&:to_i).inject(:+)
  end
end

max = 0
100.times do |a|
  100.times do |b|
    sum = (a**b).digit_sum
    max = sum if max < sum
  end
end

p max