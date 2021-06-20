# Digit cancelling fractions

# Problem 33
# The fraction 49/98 is a curious fraction, as an inexperienced mathematician
# in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which 
# is correct, is obtained by cancelling the 9s.

# We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

# There are exactly four non-trivial examples of this type of fraction, less 
# than one in value, and containing two digits in the numerator and 
# denominator.

# If the product of these four fractions is given in its lowest common terms, 
# find the value of the denominator.

class Integer
  def common_digits(other)
    digits = self.to_s.split("").map(&:to_i)
    o_digits = other.to_s.split("").map(&:to_i)
    digits & o_digits
  end
end

class Fraction
  attr_accessor :numerator, :denominator
  
  def initialize(numerator, denominator)
    self.numerator = numerator
    self.denominator = denominator
  end

  def simplify
    top, bottom = self.numerator, self.denominator
    divisor = 2
    until divisor > top # Assumes proper fraction
      while top % divisor == 0 and bottom % divisor == 0
        top /= divisor
        bottom /= divisor
      end
      divisor += 1
    end
    self.class.new(top, bottom)
  end

  def ==(other)
    a, b = self.simplify, other.simplify
    a.numerator == b.numerator and a.denominator == b.denominator
  end

  def *(other)
    self.class.new(self.numerator * other.numerator, self.denominator * other.denominator)
  end

  def digit_cancellation?
    in_common = self.numerator.common_digits(self.denominator)
    return false if in_common.empty?
    # remove trivial examples
    return false if self.numerator == self.denominator
    return false if in_common.include?(0)
    for common in in_common
      # remove common digits
      a = (self.numerator.to_s.split("") - [common.to_s]).join("").to_i
      b = (self.denominator.to_s.split("") - [common.to_s]).join("").to_i
      candidate = Fraction.new(a, b)
      if self == candidate # check if their equal
        # p [common, self, candidate]
        return true
      end
    end
    return false
  end
end


# Quick tests; Seem alright
p Fraction.new(13, 39)
p Fraction.new(10, 100) == Fraction.new(1, 10)
p Fraction.new(1, 100) == Fraction.new(3, 20)

# Quick tests; Seem alright
p Fraction.new(48, 98).digit_cancellation?
p Fraction.new(49, 98).digit_cancellation?

# What was giving me trouble for a little while was not knowing they had to be
# two digits! (How was I supposed to assume that?) If you go to a thousand,
# there are way more!

require "set"

fractions = Set.new()

(10..100).each do |a|
  (a..100).each do |b|
    fraction = Fraction.new(a, b)
    fractions << fraction if fraction.digit_cancellation?
  end
end

p fractions.map {|fraction| fraction}.inject(:*).simplify.denominator