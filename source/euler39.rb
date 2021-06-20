# Integer right triangles

# Problem 39
# If p is the perimeter of a right angle triangle with integral length sides, 
# {a,b,c}, there are exactly three solutions for p = 120.

# {20,48,52}, {24,45,51}, {30,40,50}

# For which value of p ≤ 1000, is the number of solutions maximised?

def perimeter_to_sides(perimeter)
  solutions = []
  # C (the hypotenuse) is always the longest and so can't be smaller than 1/3rd
  # of the perimeter, but as it gets longer, it flattens the triangle, until at
  # p / 2 it turns into a line.
  (perimeter / 2).downto(perimeter / 3).each do |c|
    remaining = perimeter - c
    # just making it the biggest (of a & b) to save on cycles
    ((remaining / 2)..(remaining - 1)).each do |b|
      a = remaining - b
      solutions << [a, b, c] if a * a + b * b == c * c
    end
  end
  solutions
end

# works
p perimeter_to_sides(120)

solutions = (1..1000).map {|perimeter| perimeter_to_sides(perimeter)}
p solutions.each_index.max_by {|i| solutions[i].length} + 1