# Goldbach's other conjecture

# Problem 46
# It was proposed by Christian Goldbach that every odd composite number can be 
# written as the sum of a prime and twice a square.

# 9 = 7 + 2×12
# 15 = 7 + 2×22
# 21 = 3 + 2×32
# 25 = 7 + 2×32
# 27 = 19 + 2×22
# 33 = 31 + 2×12

# It turns out that the conjecture was false.

# What is the smallest odd composite that cannot be written as the sum of a 
# prime and twice a square?

class Integer
  def prime?
    return false if self == 1 # 1 isn't prime
    return true if self == 2
    return false if self % 2 == 0
    i = 3
    until i * i > self
      return false if self % i == 0
      i += 2
    end
    return true
  end

  def goldbach_sum
    squares = ((Math.sqrt(self / 2).floor).downto(1)).map {|n| n * n}
    # p squares
    squares.each {|s| return [self - 2 * s, 2 * s] if (self - (2 * s)).prime? }
    false
  end
end

# Tests coming out well
p 9.goldbach_sum
p 15.goldbach_sum
p 21.goldbach_sum
p 25.goldbach_sum
p 27.goldbach_sum
p 31.goldbach_sum
p 3.goldbach_sum

n = 31
while true
  n += 2
  next if n.prime?
  break p n unless n.goldbach_sum
end