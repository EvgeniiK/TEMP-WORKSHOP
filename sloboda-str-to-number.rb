ar_string = gets.chomp.downcase.split("")

chars = {}

ar_string.each do |char|
  if chars[char] != nil
    chars[char] += 1
  else
    chars[char] = 1
  end
end

amounts = chars.values.sort.reverse
result = 0
weight = 26

amounts.each do |value|
  result += value * weight
  weight -= 1
end

puts result
