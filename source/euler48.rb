# Self powers

# Problem 48
# The series, 11 + 22 + 33 + ... + 1010 = 10405071317.

# Find the last ten digits of the series, 11 + 22 + 33 + ... + 10001000.

# Uh, this seems a little obvious and direct

def self_powers(range)
  range.map {|i| i**i}.inject(:+)
end

# Quick Test; Seems good
p self_powers(1..10)

p self_powers(1..1000).to_s[-10..]