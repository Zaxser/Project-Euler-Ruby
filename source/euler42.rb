# Coded triangle numbers

# Problem 42
# The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1); 
# so the first ten triangle numbers are:

# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

# By converting each letter in a word to a number corresponding to its 
# alphabetical position and adding these values we form a word value. For 
# example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value 
# is a triangle number then we shall call the word a triangle word.

# Using words.txt (right click and 'Save Link/Target As...'), a 16K text file 
# containing nearly two-thousand common English words, how many are triangle 
# words?

class Integer
  def nth_triangle
    self / 2 * (self + 1)
  end

  # n / 2 * (n + 1) = t
  # 2t = n * (n + 1) # Sanity Check: 110 = 10 * (10 + 1) # Good!
  # 2t = n^2 + n # 110 = 10^2 + 10
  # Quadratic Formula?
  # n^2 + n -2t = 0
  # n = (-1 +- sqrt(1^2 + 4(a2t))) / 2
  # n = (-1 +- sqrt(1 + 8t)) / 2
  # It turns out, a number t is a triangular number if 8t + 1 is a perfect
  # square.

  def triangle_index()
    (Math.sqrt(1 + (8 * self)) - 1) / 2
  end

  def triangular?
    (self.triangle_index % 1).zero?
  end
end

p 10.nth_triangle # So far, so good.
p 55.triangle_index # Seems to work!
p 55.triangular?

class String
  def letter_score
    letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    letters.index(self) + 1
  end

  def name_score
    self.each_char.map {|char| char.letter_score}.inject(:+)
  end
end

p "SKY".name_score
names = open("../input/euler42.txt").read()[1...-1].split('","')

scores = names.map.with_index {|name, index| name.name_score}

p scores.select(&:triangular?).length