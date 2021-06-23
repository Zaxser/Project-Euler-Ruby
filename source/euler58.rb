# Spiral primes

# Problem 58
# Starting with 1 and spiralling anticlockwise in the following way, a square 
# spiral with side length 7 is formed.

# 37 36 35 34 33 32 31
# 38 17 16 15 14 13 30
# 39 18  5  4  3 12 29
# 40 19  6  1  2 11 28
# 41 20  7  8  9 10 27
# 42 21 22 23 24 25 26
# 43 44 45 46 47 48 49

# It is interesting to note that the odd squares lie along the bottom right 
# diagonal, but what is more interesting is that 8 out of the 13 numbers lying 
# along both diagonals are prime; that is, a ratio of 8/13 ≈ 62%.

# If one complete new layer is wrapped around the spiral above, a square spiral 
# with side length 9 will be formed. If this process is continued, what is the 
# side length of the square spiral for which the ratio of primes along both 
# diagonals first falls below 10%?
require "set"

class Integer
  # This is gnarly; there are prettier ways I could've written this, but they
  # are much slower.
  def primes_below(known_primes=[2])
    return [] if self < 3
    primes = known_primes
    n = known_primes.length > 1 ? known_primes[-1] : 3
    until n >= self
      prime = false
      primes.each do |p|
        break if n % p == 0
        if p * p > n
          prime = true
          break
        end
      end
      primes << n if prime
      n += 2
    end
    primes
  end
end

class Spiral
  attr_accessor :grid, :direction, :distance, :value, :spin_direction, :size,
  :max_size, :primes, :diagonal_primes, :diagonals

  def initialize(n, direction=:right, spin_direction=:counter_clockwise)
    self.grid = []
    self.direction = :right
    self.spin_direction = spin_direction
    self.distance = 0
    self.value = 0
    self.max_size = n
    self.size = 1
    self.primes = [2]
    self.diagonal_primes = []
    self.diagonals = [1]

    incremental_draw()
  end

  def incremental_draw()
    until self.size >= self.max_size
      self.next()
    end
  end

  def draw
    until grid.length >= self.size and grid[0].length >= self.size
      next right() if self.direction == :right
      next down()  if self.direction == :down
      next left()  if self.direction == :left
      next up()    if self.direction == :up
    end
  end

  def next()
    self.size += 2 # Project Euler only likes odd sizes; them's the breaks
    draw()
    new_diagonals = [
      self.grid[0][0], self.grid[0][-1], self.grid[-1][0], self.grid[-1][-1]
    ]
    self.primes = self.value.primes_below(self.primes)
    self.diagonals += new_diagonals
    self.diagonal_primes += new_diagonals.select {|d| self.primes.include? d}

  end

  def right()
    self.distance += 1
    if self.spin_direction == :clockwise
      self.grid.unshift([])
      level = 0
    else
      self.grid << []
      level = -1
    end
    distance.times do
      self.value += 1 
      self.grid[level].push(value)
    end
    self.direction = self.spin_direction == :clockwise ? :down : :up
  end

  def down()
    grid.length.times do |level|
      self.value += 1
      if self.spin_direction == :clockwise
        self.grid[level].push(self.value)
      else
        self.grid[level].unshift(self.value)
      end
    end
    self.direction = self.spin_direction == :clockwise ? :left : :right
  end

  def left()
    self.distance += 1
    if self.spin_direction == :clockwise
      self.grid << []
      level = -1
    else
      self.grid.unshift([])
      level = 0
    end
    self.distance.times do
      self.value += 1
      self.grid[level].unshift(value)
    end
    self.direction = self.spin_direction == :clockwise ? :up : :down
  end

  def up()
    grid.length.times do |level|
      self.value += 1
      if self.spin_direction == :clockwise
        self.grid[-level - 1].unshift(self.value)
      else
        self.grid[-level - 1].push(self.value)
      end
    end
    self.direction = self.spin_direction == :clockwise ? :right : :left
  end

  def print()
    self.grid.each do |line|
      puts line.map(&:to_s).join("\t")
    end
  end

  def diagonal_sum
    diagonals.inject(:+)
  end

  def diagonal_prime_ratio
    self.diagonal_primes.length.to_f / self.diagonals.length
  end

end

# Worked the spiral out so it would spin the other way; theoretically there are
# eight combinations (counter / clockwise) * (left, right, up, down), but I
# haven't tested them yet.

# spiral = Spiral.new(7)
# # spiral.print
# p spiral.diagonals
# p spiral.diagonal_sum
# p spiral.diagonal_primes
# p spiral.diagonal_prime_ratio
# spiral = Spiral.new(9)
# p spiral.diagonal_prime_ratio

# while spiral.diagonal_prime_ratio > 0.1
#   spiral.next()
#   p [spiral.size, spiral.diagonal_prime_ratio]
# end

# Hmm. Seems just a little too slow, once it starts getting into the 500s or so.
# The answer is 696 and it takes a few minutes.
# p spiral.size
# It looks like Project Euler only excepts odd sizes; a quick look at the
# output reveals that even sizes have much lower prime ratios than odd sizes.

# I refigured this program significantly; I made next to add layer to the 
# spiral instead of having to create an entire spiral object each time, made 
# next go up by twos instead of 1s, made my "primes_up_to" method able to take
# a list of known primes so that it wouldn't need to recreate the prime list
# each time. This made it significantly faster; it doesn't start to get slow
# until somewhere in the 4000s, and even then not truly slow. I think this is
# probably still a bit too slow, but I suspect it'll hit the true answer,
# (somewhere in 20,000s, I think?) before I solve the problem with better
# analysis.

# I streamlined it below as it was breaking into 1400s. It's still too slow.

# This may require some analysis. Obviously, if to get the daigonals, it isn't
# necessary is write the whole thing, just getting the angles starts, with one,
# you add, twos, then you add fours, sixes, etc.

# value = 1
# diagonals = [value]
# primes = [2]
# diagonal_primes = []
# increment = 2
# size = 1
# ratio = 1
# until ratio < 0.1
#   new_diagonals = []
#   4.times { new_diagonals << value += increment}
#   increment += 2
#   size += 2
#   diagonals += new_diagonals
#   primes = (value + 1).primes_below(primes)
#   diagonal_primes += new_diagonals.select {|d| primes.include? d}
#   ratio = diagonal_primes.length.to_f / diagonals.length
#   p size if (size - 1) % 100 == 0
# end

# p size, ratio

# This is still a too slow, but seems significantly faster than the earlier 
# solution.

# 37 36 35 34 33 32 31
# 38 17 16 15 14 13 30
# 39 18  5  4  3 12 29
# 40 19  6  1  2 11 28
# 41 20  7  8  9 10 27
# 42 21 22 23 24 25 26
# 43 44 45 46 47 48 49

# 1, 9, 25
# 1^2, 3^2, 5^2, 7^2
# n => ((1 + 2)*n)^2 # Maybe we can skip calculating these, as none of them can
                     # be prime
# 1, 3, 13, 31
# 1^2, 3^2 - 6, 5^2 - 12, 7^2 - 18
# n => ((1 + 2)*n)^2 - (6 * n)

# 1, 5, 17
# 1^2 - 0, 3^2 - 4, 5^2 - 8, 7^2  -12
# n => ((1 + 2)*n)^2 - (4 * n)

# 1, 7, 21, 43
# n => ((1 + 2)*n)^2 - 2n

# Hmm. If we check for primeness as we go, we don't need to keen a list of
# diagonals, we can just count them as we go.

# Made this as the one above was breaking 18,000. Let's see if this goes
# better. It'll certainly be less memory intensive.

# This is still too slow!

# diagonals = 1
# primes = [2]
# diagonal_primes = 0
# n = 0
# size = 1
# ratio = 1
# until  ratio < 0.1
#   n += 1
#   base = (1 + 2*n)**2
#   new_diagonals = [base - (6 * n), base - (4 * n), base - (2 * n)]
#   diagonals += 4
#   size += 2
#   # Base is always a square and therefore, never prime
#   primes = base.primes_below(primes)
#   diagonal_primes += new_diagonals.count {|d| primes.include? d}
#   ratio = diagonal_primes / diagonals.to_f
#   p size if (size - 1) % 100 == 0
# end

# p size
# This is still like crazy galactic slow.

# What if we just replace my prime with a better prime library?

# Holy shit this is prime fast. Or, my prime is still really slow.
# One day I really have to go look at prime algos seriously.
require "prime"

diagonals = 1
diagonal_primes = 0
size = 1
ratio = 1
n = 0
until  ratio < 0.1
  n += 1
  size += 2
  base = (1 + 2*n)**2
  new_diagonals = [base - (6 * n), base - (4 * n), base - (2 * n)]
  diagonals += 4
  diagonal_primes += new_diagonals.count(&:prime?)
  ratio = diagonal_primes / diagonals.to_f
  p size if (size - 1) % 100 == 0
end

p size