# Lattice paths

# Problem 15
# Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.


# How many such routes are there through a 20×20 grid?

# This works, and is elegant as FUCK, but it's way too slow for 20, 20
def lattice_paths(x, y)
  return 1 if x == 0 or y == 0
  lattice_paths(x - 1, y) + lattice_paths(x, y - 1)
end

# p lattice_paths(1, 1)
# p lattice_paths(2, 2)
# p lattice_paths(3, 3)
# p lattice_paths(4, 4)
# p lattice_paths(20, 20)

# Having to work this out; it's been a while since I studied combinatorics.
# Was tempted to solve this by drawing Pascal's Triangle, but that's a PITA
# in it's own way; this was more interesting and results in way faster code.

# # 1 lattice; 2 paths; 2! = 2; 2^2 = 4; 2 /2 = 1 (1^2), 1 = !!
# # 2 lattice; 6 paths; 4! = 24; 2^4 = 16; 24 / 6 = 4 (2^2), 2 = 2!
# # 3 lattice; 20 paths; 6! = 720; 2^6 = 64; 720 / 20 = 36 (6^2), 6 = 3!
# # 4 lattice; 70 paths; 8! 40320; 2^8 = 256; 40320 / 70 = 576 (24^2), 24 = 4!
# x lattice = (x*2)! / x!^2

# Works; would be cool to generalize for all coordinates, rather than just for
# traveling squares.
class Integer
  def factorial
    (1..self).inject(:*)
  end

  def lattice_square
    (self * 2).factorial / self.factorial**2
  end
end

p 1.lattice_square
p 2.lattice_square
p 3.lattice_square
p 4.lattice_square
p 20.lattice_square