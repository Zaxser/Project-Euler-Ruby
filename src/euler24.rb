# Lexicographic permutations

# Problem 24
# A permutation is an ordered arrangement of objects. For example, 3124 is one 
# possible permutation of the digits 1, 2, 3 and 4. If all of the permutations 
# are listed numerically or alphabetically, we call it lexicographic order. The
# lexicographic permutations of 0, 1 and 2 are:

# 012   021   102   120   201   210

# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 
# 5, 6, 7, 8 and 9?


class Array
  def nth_permatation(n)
    self.permutation.each_with_index {|e, i| return e if i == n}
  end
end

p [0,1,2,3,4,5,6,7,8,9].nth_permatation(999_999).map {|i| i.to_s}.join("")

# There is a method that'll generate permutations in lexicographic order, but
# that feels like too much cheese for me, so I'd really like to give it a shot 
# solving this with analysis at some point, but right now I'd like to move on 
# to the next problem.

# In the mean time, a hint to my future self:

# It looks like the way permuations increment has something to do with a
# pattern of 9s.

# 01
# 10 + 9

# 012   
# 021 + 9   
# 102 + 81  
# 120 + 18 # Interesting that this itself is a permuatation. 
# 201 + 81
# 210 + 9
