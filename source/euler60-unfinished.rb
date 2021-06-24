# Prime pair sets

# Problem 60
# The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes 
# and concatenating them in any order the result will always be prime. For 
# example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these 
# four primes, 792, represents the lowest sum for a set of four primes with 
# this property.

# Find the lowest sum for a set of five primes for which any two primes 
# concatenate to produce another prime.

require "prime"
require "set"


class Array
  def concats
    self.permutation(2).map do |combo|
      combo.map(&:to_s).inject(:+).to_i
    end
  end
  def prime_pair_set?
    self.concats.all? {|c| c.prime?}
  end
  
end

# p [3, 7, 109, 673].prime_pair_set?
# This solves it for four families, but is still a little slow.

primes = []
def euler60(family_size)
  primes = []
  Prime.each do |pr| 
    primes.combination(family_size - 1).each do |combo|
      return (combo  + [pr]) if (combo + [pr]).prime_pair_set?
    end
    primes << pr
  end
end

# p euler60(4)
p euler60(5)
# So the major in