# Prime permutations
# Submit

#  Show HTML problem content 
# Problem 49
# The arithmetic sequence, 1487, 4817, 8147, in which each of the terms 
# increases by 3330, is unusual in two ways: (i) each of the three terms are 
# prime, and, (ii) each of the 4-digit numbers are permutations of one another.

# There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, 
# exhibiting this property, but there is one other 4-digit increasing sequence.

# What 12-digit number do you form by concatenating the three terms in this 
# sequence?

class Integer
  def permutation
    self.to_s.split("").sort.permutation.map do |p| 
      p.map(&:to_s).join("").to_i
    end
  end

  def prime? # Assumes positive integers
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

  def prime_permuations
    self.permutation.select(&:prime?)
  end
end

# That's friggin' annoying
p 1487.prime_permuations # !

class Integer
  def permutation?(other)
    self.to_s.split("").sort == other.to_s.split("").sort
  end

  def incremental_permuation_primes(increment)
    n, results, candidate = 0, [], self
    while candidate.permutation?(self) and candidate.prime?
      results << candidate
      n += 1
      candidate += increment
    end
    results
  end
end

# Alright. That works.
p 1487.incremental_permuation_primes(3330)
p 1487.incremental_permuation_primes(3330).length
# 4_400 = 10_000 - (3_300 * 2), so higher than the cap of four digit 
# permuations.
solutions = (1_000...4_400).select do |n| 
  n.incremental_permuation_primes(3330).length == 3
end


# p solutions.map {|s| s.incremental_permuation_primes(3300)}

# Oh, right. Forgot the last part.
p solutions[1].incremental_permuation_primes(3330).map(&:to_s).join("").to_i