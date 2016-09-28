def get_length(number)
  numbers_lib = {}
  numbers_lib["0"] = ""
  numbers_lib["1"] = "один"
  numbers_lib["2"] = "два"
  numbers_lib["3"] = "три"
  numbers_lib["4"] = "четыре"
  numbers_lib["5"] = "пять"
  numbers_lib["6"] = "шесть"
  numbers_lib["7"] = "семь"
  numbers_lib["8"] = "восемь"
  numbers_lib["9"] = "девять"
  numbers_lib["10"] = "десять"
  numbers_lib["11"] = "одинадцать"
  numbers_lib["12"] = "двенадцать"
  numbers_lib["13"] = "тринадцать"
  numbers_lib["14"] = "четырнадцать"
  numbers_lib["15"] = "пятнадцать"
  numbers_lib["16"] = "шестнадцать"
  numbers_lib["17"] = "семнадцать"
  numbers_lib["18"] = "восемнадцать"
  numbers_lib["19"] = "девятнадцать"
  numbers_lib["20"] = "двадцать"
  numbers_lib["30"] = "тридцать"
  numbers_lib["40"] = "сорок"
  numbers_lib["50"] = "пятдесят"
  numbers_lib["60"] = "шестдесят"
  numbers_lib["70"] = "семдесят"
  numbers_lib["80"] = "восемдесят"
  numbers_lib["90"] = "девяносто"
  numbers_lib["100"] = "сто"
  numbers_lib["200"] = "двести"
  numbers_lib["300"] = "тристо"
  numbers_lib["400"] = "четыресто"
  numbers_lib["500"] = "пятьсот"
  numbers_lib["600"] = "шестьсот"
  numbers_lib["700"] = "семьсот"
  numbers_lib["800"] = "восемьсот"
  numbers_lib["900"] = "девятьсот"
  numbers_lib["1000"] = "тысяча"

  if numbers_lib[number.to_s] != nil
    return numbers_lib[number.to_s].length
  elsif number > 20 && number < 100
    parsed_number = number.to_s.split("")
    parsed_number[0] = parsed_number[0].to_i * 10
    parsed_number[0] = parsed_number[0].to_s
    str_val = numbers_lib[parsed_number[0]] + numbers_lib[parsed_number[1]]
    return str_val.length
  else
    parsed_number = number.to_s.split("")
    parsed_number[0] = parsed_number[0].to_i * 100
    parsed_number[0] = parsed_number[0].to_s
    parsed_number[1] = parsed_number[1].to_i * 10
    parsed_number[1] = parsed_number[1].to_s
    str_val = numbers_lib[parsed_number[0]] + numbers_lib[parsed_number[1]] + \
    numbers_lib[parsed_number[2]]
    return str_val.length
  end
end

result = 0

(1..1000).each do |i|
  result += get_length(i)
end

puts result
