input = gets.chomp.downcase.split("")

chars = {}

input.each do |element|
  if ("a".."z").include?(element)
    if chars[element] != nil
      chars[element] += 1
    else
      chars[element] = 1
    end
  end
end

print chars
