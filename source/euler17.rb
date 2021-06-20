# Number letter counts

# Problem 17
# If the numbers 1 to 5 are written out in words: one, two, three, four, five, 
# then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

# If all the numbers from 1 to 1000 (one thousand) inclusive were written out 
# in words, how many letters would be used?


# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and 
# forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 
# letters. The use of "and" when writing out numbers is in compliance with 
# British usage.

class Integer
  def to_words    # "" for easy indexing
    ones_place = ["", "one", "two", "three", "four", "five", "six", 
                  "seven", "eight", "nine", "ten", "eleven", "twelve", 
                  "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", 
                  "eighteen", "nineteen"]
                  # empty stings for easy indexing
    tens_place = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", 
                  "seventy", "eighty", "ninety"]
    
    return "out of range" if self < 0
    return ones_place[self] if self < 20
    return tens_place[self / 10] + " " + ones_place[self % 10] if self < 100
    if self < 1000
      result = ones_place[self / 100] + " hundred"
      result += " and " + (self % 100).to_words if self % 100 != 0
      return result
    end
    if self < 1_000_000
      return (self / 1000).to_words + " thousand " + (self % 1000).to_words
    end
    return "out of range"
  end
end

# just a quick test; I need to remember to exclude zero when I do it for real.
1_000.times do |n|
  puts (n + 1).to_words
end

def sum_of_words(n)
  sum = 0
  n.times do |n|
    sum += (n + 1).to_words.tr(" ", "").length
  end
  return sum
end

p sum_of_words(5)
p sum_of_words(1_000)

# cheesey solution
require 'humanize'

p (1..1000).to_a.map(&:humanize).join.tr(" -", "").size