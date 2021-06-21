# Prime digit replacements
 
# Problem 51
# By replacing the 1st digit of the 2-digit number *3, it turns out that six of 
# the nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.

# By replacing the 3rd and 4th digits of 56**3 with the same digit, this 
# 5-digit number is the first example having seven primes among the ten 
# generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663, 
# 56773, and 56993. Consequently 56003, being the first member of this family, 
# is the smallest prime with this property.

# Find the smallest prime which, by replacing part of the number (not 
# necessarily adjacent digits) with the same digit, is part of an eight prime
# value family.

class Integer
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

  def replacement_family(indexes) # Job 42:13 lol
    string = self.to_s
    range =  ((indexes.include?(0) ? '1' : '0')..'9')
    range.map do |n|
      next if n == '0' and indexes.include?(0)
      clone = string.dup
      indexes.each {|i| clone[i] = n}
      clone.to_i 
    end
  end

  def prime_family(indexes)
    self.replacement_family(indexes).select(&:prime?)  
  end

  def length
    Math.log10(self).to_i + 1
  end
end

# Quick Tests
p 13.replacement_family([0])
p 103.replacement_family([1])
p 56003.replacement_family([2, 3])
p 13.prime_family([0])
p 56003.prime_family([2, 3])

# This is really slow; it seems like their should be a faster way to get
# through / increment each number (by analysis) than to go through them one or
# two at a time, but I'm not sure how to go about it. Maybe you could check for
# 0s and skip over a number unless it had at least one? Not sure.
n = 11
found = false
until found
  # next unless n.to_s.include?("0")
  n.length.times do |length|
    (0...n.length).to_a.combination(length).to_a.each do |c| 
      if n.prime_family(c).length == 8
        found = true
        p n.prime_family(c)[0]
        break
      end
    end
  end
  n+= 2
  # p n if n % 1000 == 0
end