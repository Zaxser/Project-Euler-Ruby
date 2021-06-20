# Pentagon numbers

# Problem 44
# Pentagonal numbers are generated by the formula, Pn=n(3n−1)/2. The first ten 
# pentagonal numbers are:

# 1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...

# It can be seen that P4 + P7 = 22 + 70 = 92 = P8. However, their difference, 
# 70 − 22 = 48, is not pentagonal.

# Find the pair of pentagonal numbers, Pj and Pk, for which their sum and 
# difference are pentagonal and D = |Pk − Pj| is minimised; what is the value 
# of D?

class Integer
  def nth_pentagonal
    self * (3 * self - 1) / 2
  end

  # p = n * (3 * n - 1) / 2
  # 2p = n * (3n - 1)
  # 2p = 3n^2 - n
  # 3n^2 - n - 2p = 0
  # Quadratic Formula!
  # n = 1 +- Math.sqrt(1 - 4(3)(-2)p) / 2(3)
  # n = 1 + Math.sqrt(1 + 24p) / 6
  def pentagonal_index
    (1 + Math.sqrt(24 * self.abs + 1)) / 6
  end

  def pentagonal?
    (self.pentagonal_index % 1).zero?
  end
end

p 4.nth_pentagonal
p 7.nth_pentagonal
p 4.nth_pentagonal.pentagonal?
p 7.nth_pentagonal.pentagonal?

finished = false

(1..10_000).each do |j|
  break if finished
  (1..10_000).each do |k|
    next if j == k
    pj = j.nth_pentagonal
    pk = k.nth_pentagonal 
    difference = pk - pj
    next unless difference.pentagonal?
    sum = pk + pj
    next unless sum.pentagonal?
    p pk - pj
    finished = true
    break
  end
end