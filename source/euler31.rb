# Coin sums

# Problem 31
# In the United Kingdom the currency is made up of pound (£) and pence (p). 
# There are eight coins in general circulation:

# 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), and £2 (200p).
# It is possible to make £2 in the following way:

# 1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
# How many different ways can £2 be made using any number of coins?

def change_ways(amount, coins)
  coins = coins.sort.reverse
  ways = 0
  coins.each_with_index do |coin, index|
    if amount == coin
      ways += 1
    elsif amount > coin
      ways += change_ways(amount - coin, coins[index..])
    end
  end
  ways
end

# Quick Tests; Seem good
p change_ways(2, [2, 1])
p change_ways(3, [2, 1])
p change_ways(10, [10, 5])
p change_ways(10, [10, 5, 1])
p change_ways(20, [10, 5, 1])
# 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), and £2 (200p).
p change_ways(200, [200, 100, 50, 20, 10, 5, 2, 1])