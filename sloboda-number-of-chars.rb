input = gets.chomp.downcase.split("")

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

chars.each do |char|
  print char + ": " + amount[chars.index(char)].to_s + "\n"
end
