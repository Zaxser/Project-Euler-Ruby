# Amicable numbers

# Problem 21
# Let d(n) be defined as the sum of proper divisors of n (numbers less than n 
# which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and 
# each of a and b are called amicable numbers.

# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 
# 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 
# 71 and 142; so d(284) = 220.

# Evaluate the sum of all the amicable numbers under 10000.

require "set"

class Integer
  def divisors
    divisors = SortedSet.new([1, self])
    n = 2
    until n * n > self
      divisors += [n, self / n] if self % n == 0
      n += 1
    end
    return divisors
  end

  def proper_divisors
    self.divisors - [self]
  end

  def d # sum of proper divisors; see instructions
    proper_divisors = self.proper_divisors
    return 0 if proper_divisors.empty? # 1 gave me some trouble here
    self.proper_divisors.inject(:+)
  end

  def amicable?
    return false if self.proper_divisors.empty? # 1 gave me some trouble here
    sum = self.d
    # I ended up getting a few too the first time because I forgot the second
    # half.
    self == sum.d and self != sum
  end
end

# Some quick tests
p [220, 220.d]
p 220.amicable?

p (1..10_000).select { |n| n.amicable? }.inject(:+)