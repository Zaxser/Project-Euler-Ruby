# Names scores

# Problem 22
# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file 
# containing over five-thousand first names, begin by sorting it into 
# alphabetical order. Then working out the alphabetical value for each name, 
# multiply this value by its alphabetical position in the list to obtain a name 
# score.

# For example, when the list is sorted into alphabetical order, COLIN, which is
# worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN 
# would obtain a score of 938 × 53 = 49714.

# What is the total of all the name scores in the file?

class String
  def letter_score
    letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    letters.index(self) + 1
  end

  def name_score
    self.each_char.map {|char| char.letter_score}.inject(:+)
  end
end


p "COLIN".name_score # Little test; seems to work

# p "A ".name_score # Yay! It fails. That'll save me some time.

names = open("../input/euler22.txt").read()[1...-1].split('","')
names.sort!
p names.find_index("COLIN") # Little test; off by one, as expected

scores = names.map.with_index {|name, index| name.name_score * (index + 1)}

p scores.inject(:+)