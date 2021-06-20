# Number spiral diagonals

# Problem 28
# Starting with the number 1 and moving to the right in a clockwise direction a
# 5 by 5 spiral is formed as follows:

# 21 22 23 24 25
# 20  7  8  9 10
# 19  6  1  2 11
# 18  5  4  3 12
# 17 16 15 14 13

# It can be verified that the sum of the numbers on the diagonals is 101.

# What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral 
# formed in the same way?

class Spiral
  attr_accessor :grid, :direction, :distance, :value

  def initialize(n)
    self.grid = []
    self.direction = :right
    self.distance = 0
    self.value = 0

    until grid.length >= n and grid[0].length >= n
      next right() if direction == :right
      next down()  if direction == :down
      next left()  if direction == :left
      next up()    if direction == :up
    end
  end

  def right()
    self.distance += 1
    self.grid.unshift([])
    distance.times do
      self.value += 1
      self.grid[0].push(value)
    end
    self.direction = :down
  end

  def down()
    level = 0
    distance.times do
      self.value += 1
      self.grid[level].push(self.value)
      level += 1
    end
    self.direction = :left
  end

  def left()
    self.distance += 1
    self.grid.push([])
    distance.times do
      self.value += 1
      self.grid[-1].unshift(value)
    end
    self.direction = :up
  end

  def up()
    level = -1
    distance.times do
      self.value += 1
      self.grid[level].unshift(self.value)
      level -= 1
    end
    self.direction = :right
  end

  def print()
    self.grid.each do |line|
      puts line.map(&:to_s).join("\t")
    end
  end

  def diagonal_sum()
    sum = 0
    
    reverse = self.grid.map do |line|
      line.reverse
    end
    
    self.grid.length.times do |n|
      sum += self.grid[n][n] + reverse[n][n]
    end

    sum -= 1 if self.grid.length.odd? # remove double counted middle / 1s
    sum
  end
end

Spiral.new(1).print # So far, so good.
Spiral.new(2).print # I got it working.
Spiral.new(3).print # I think that worked
Spiral.new(5).print # Sweet!

p Spiral.new(5).diagonal_sum # Quick test; appears to work!

p Spiral.new(1001).diagonal_sum