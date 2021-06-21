# Permuted multiples

# Problem 52
# It can be seen that the number, 125874, and its double, 251748, contain 
# exactly the same digits, but in a different order.

# Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, 
# contain the same digits.

class Integer
  def permutation?(other)
    self.to_s.split("").to_a.sort == other.to_s.split("").to_a.sort
  end

  def euler52?
    return false unless permutation?(self * 2)
    return false unless permutation?(self * 3)
    return false unless permutation?(self * 4)
    return false unless permutation?(self * 5)
    return false unless permutation?(self * 6)
    true
  end
end

n = 10
n += 1 until n.euler52?
p n