# Longest Collatz sequence

# Problem 14
# The following iterative sequence is defined for the set of positive integers:

# n → n/2 (n is even)
# n → 3n + 1 (n is odd)

# Using the rule above and starting with 13, we generate the following sequence:

# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

# Which starting number, under one million, produces the longest chain?

# NOTE: Once the chain starts the terms are allowed to go above one million.

# Decided to write it so that it kept the entire sequence; this is probably
# slower and definitely more memory intensive, but WAY easier to test.
class Integer
  def collatz_sequence
    n = self
    sequence = [self]
    while n != 1
      n.even? ? n /= 2 : n = (3 * n) + 1
      sequence << n
    end
    return sequence
  end
end

p 13.collatz_sequence

longest = 1
length = 1
1_000_000.times do |n|
  n = n + 1
  sequence = n.collatz_sequence
  if sequence.length > length
    length = sequence.length
    longest = n
  end
end
p longest