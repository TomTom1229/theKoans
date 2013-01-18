# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  if [a, b, c].any? do |one| one <= 0 end then raise TriangleError end
  if [a, b, c].permutation(3).any? do |a,b,c| a + b <= c end then raise TriangleError end
  equal = 0
  if(a==b) then equal += 1 end
  if(a==c) then equal += 1 end
  if(b==c) then equal += 1 end
  case equal
  when 3
	return :equilateral
  when 1
	return :isosceles
  else
	return :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
