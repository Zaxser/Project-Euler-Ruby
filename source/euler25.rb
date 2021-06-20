# 1000-digit Fibonacci number

# Problem 25
# The Fibonacci sequence is defined by the recurrence relation:

# Fn = Fn−1 + Fn−2, where F1 = 1 and F2 = 1.
# Hence the first 12 terms will be:

# F1 = 1
# F2 = 1
# F3 = 2
# F4 = 3
# F5 = 5
# F6 = 8
# F7 = 13
# F8 = 21
# F9 = 34
# F10 = 55
# F11 = 89
# F12 = 144
# The 12th term, F12, is the first term to contain three digits.

# What is the index of the first term in the Fibonacci sequence to contain 1000
# digits?

# This is rather direct and obvious; I'm curious what they meant for me to 
# discover here.

a = b = f_index = 1

until a.to_s.length > 999
  c = a
  a = b
  b += c
  f_index += 1
end

p a, f_index