def find_square(num)
  return num if num.zero?
  return find_square(num - 1) + 2 * num - 1
end

p find_square(5) == 25
p find_square(10) == 100
p find_square(100) == 10000