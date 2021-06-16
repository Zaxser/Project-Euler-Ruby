# Largest prime factor

# Problem 3
# The prime factors of 13195 are 5, 7, 13 and 29.

# What is the largest prime factor of the number 600851475143 ?

require "set"
def prime_factors(n)
  i = 2
  prime_factors = Set.new()
  until i * i > n
    while n % i == 0
      n /= i
      prime_factors.add(i)
    end
    i += 1
  end
  prime_factors.add(n)
  return prime_factors
end

puts(prime_factors(13195))
puts(prime_factors(600851475143))