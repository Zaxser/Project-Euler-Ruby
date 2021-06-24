# Arranged probability
# Submit

#  Show HTML problem content 
# Problem 100
# If a box contains twenty-one coloured discs, composed of fifteen blue discs 
# and six red discs, and two discs were taken at random, it can be seen that 
# the probability of taking two blue discs, P(BB) = (15/21)×(14/20) = 1/2.

# The next such arrangement, for which there is exactly 50% chance of taking 
# two blue discs at random, is a box containing eighty-five blue discs and 
# thirty-five red discs.

# By finding the first arrangement to contain over 1012 = 1,000,000,000,000 
# discs in total, determine the number of blue discs that the box would contain.

# Let's see if we can iterate this and see if we find a good pattern.

def pick_two_blue(blue, red)
  [blue * (blue - 1), (blue + red) * (blue + red - 1)]
end

p pick_two_blue(15.0, 6.0) # Seems good.

# red = 1.0
# blue = 1.0
# while true
#   fraction = pick_two_blue(blue, red)
#   pr = fraction[0] / fraction[1]
#   if pr == 0.5
#     p [fraction, blue, red, red + blue]
#     break if (red + blue) > 1_000_000_000_000
#   end
#   pr < 0.5 ? blue += 1 : red += 1
# end

# 3/ 4, 5 /7, 19/24,
# * 2 - 1 / * 2 - x^2?
# Sequence analysis might reveal something cool, but I think this might be too
# slow anyway.
# Ugh. I think I need to learn calculus to understand this. :/
# What I think I actually know based on this:
# When we start off we need 3/4 blue balls to have a 50% chance to draw two
# balls, as the total amount of balls gets larger, the proportion of blue balls 
# we need to get 50% chance of getting two blue balls get smaller and smaller,
# until at infinite, we only need half the balls to blue. This makes sense:
# with a small number of balls drawing one ball effects the odds of drawing the
# second ball a lot; with a large number, hardly at all, at infinite, zero.

red = 499_000_000_000
blue = 499_000_000_000
while true
  fraction = pick_two_blue(blue, red)
  pr = fraction[0].to_f / fraction[1]
  if pr == 0.5
    p [fraction, blue, red, red + blue]
    break if (red + blue) > 1_000_000_000_000
  end
  pr < 0.5 ? blue += 1 : red += 1
end

# 3/4, 15 / 21, 
# [[6.0, 12.0], 3.0, 1.0, 4.0]
# [[210.0, 420.0], 15.0, 6.0, 21.0]
# [[7140.0, 14280.0], 85.0, 35.0, 120.0]
# [[242556.0, 485112.0], 493.0, 204.0, 697.0]
# [[8239770.0, 16479540.0], 2871.0, 1189.0, 4060.0]
# [[279909630.0, 559819260.0], 16731.0, 6930.0, 23661.0]
# [[9508687656.0, 19017375312.0], 97513.0, 40391.0, 137904.0]
# [[323015470680.0, 646030941360.0], 568345.0, 235416.0, 803761.0]
# [[10973017315470.0, 21946034630940.0], 3312555.0, 1372105.0, 4684660.0]
# [[372759573255306.0, 745519146510612.0], 19306983.0, 7997214.0, 27304197.0]

# So little analysis here, we's basically looking for a number b where
# (b / (b + r)) * ((b - 1)/ (b + r - 1)) = 1 / 2
# (b**2 - b) / (b**2 + br + b + br + r**2 - r) = 1 / 2
# (b**2 - b) / (b**2 + 2br - b + r**2 - r) = 1 / 2
# Okay. That doesn't seem so helpful. Is there a way to seperate b from r
# that'll result in a relationship between b and r?
# (b / (b + r)) * ((b - 1)/ (b + r - 1)) = 1 / 2
# b * ((b - 1)/ (b + r - 1)) = (b + r) / 2
# b * (b - 1) = (b + r - 1) * (b + r) / 2
# b**2 - b = (b**2 + br + rb + r**2 - b - r) / 2
# 2(b**2 - b) = (b**2 + br + rb + r**2 - b - r)
# 2(b**2 - b) - (b**2 + br + rb + r**2 - b - r) = 0
# b**2 - 2br - r**2 + r = 0
# Their might be a way to do this, but let's try another track.
# P(15,8) => 1/2
# P(1, 1) => 1/ 2 * 0/1 = 0
# P(2, 1) => 2/3 * 1/2 = 2/6, 1/3
# P(3, 1) => 3/4 * 2/3 = 6/12, 1/2 # So the first that satisfies is 3, 1
# Substitution maybe?
# (b / (1,000,000,000,000)) * ((b - 1)/ (1,000,000,000,000 - 1)) = 1 / 2
# = 1 / 2
# (b**2 - b) /((n**2)-n) = 1/2
# 2(b**2 - b) /((n**2)-n) = 1
# 2b**2 - 2b = n**2 - n
# 2b**2 - 2b - n**2 + n # Sanity Check: 2(3)**2 - 6 - 16 + 4

# Diaphonic Quadratic Equation!
# -b±√(b²-4ac))/(2a)
# 1±√(1-4(2)(-n**2+n)))/(2(2))
# (1 + Math.sqrt(1+8n**2-8n))/4
# Sanity Check: (1 + Math.sqrt(1+8(21)**2-8(21)))/4
# (1 + Math.sqrt(1+8(21)**2-168))/4
# (--1+√(-1²-4(2)(--8n**2-8n))))/(2(2))
# (1+√(+1+8n**2-8n)))/(4)
# 1+√(+1+8(4)**2-8(4))))/(4)

