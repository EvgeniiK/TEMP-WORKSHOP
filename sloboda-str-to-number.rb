custom_string = gets.chomp

def get_indexes(custom_str)
  input = custom_str.downcase.split("")
  chars = []
  amount = []
  input.each do |char|
    if chars.include?(char)
      amount[chars.index(char)] += 1
    else
      chars[chars.length] = char
      amount[amount.length] = 1
    end
  end
  return amount
end

indexes = get_indexes(custom_string).sort.reverse

result = 0
start = 26

indexes.each do |indx|
  result += indx * start
  start -= 1
end

puts result
