def get_length(number)
  def find_length(value)
    numbers_lib = {}
    numbers_lib["0"] = ["0"]
    numbers_lib["4"] = ["1", "5", "7"]
    numbers_lib["3"] = ["2", "3", "100"]
    numbers_lib["6"] = ["4", "8", "9", "10", "200", "300", "1000"]
    numbers_lib["5"] = ["6", "40"]
    numbers_lib["11"] = ["11", "16", "80"]
    numbers_lib["10"] = ["12", "13", "15", "17", "60"]
    numbers_lib["12"] = ["14", "18", "19"]
    numbers_lib["8"] = ["20", "30", "600"]
    numbers_lib["9"] = ["50", "70", "90", "400", "800", "900"]
    numbers_lib["7"] = ["500", "700"]

    numbers_lib.each do |elem|
      elem[1].each do |val|
        if val == value
          return numbers_lib.key(elem[1]).to_i
        end
      end
    end
    return false
  end

  if find_length(number.to_s) != false
    return find_length(number.to_s)
  elsif number > 20 && number < 100
    parsed_number = number.to_s.split("")
    parsed_number[0] = parsed_number[0].to_i * 10
    return find_length(parsed_number[0].to_s) + find_length(parsed_number[1])
  else
    parsed_number = number.to_s.split("")
    if parsed_number[1] == "1"
      parsed_number[0] = parsed_number[0].to_i * 100
      parsed_number[1] = parsed_number[1] + parsed_number[2]
      return find_length(parsed_number[0].to_s) + find_length(parsed_number[1])
    else
      parsed_number[0] = parsed_number[0].to_i * 100
      parsed_number[1] = parsed_number[1].to_i * 10
      return find_length(parsed_number[0].to_s) + \
        find_length(parsed_number[1].to_s) + find_length(parsed_number[2])
    end
  end
end

result = 0

(1..1000).each do |i|
  result += get_length(i)
end

puts result
