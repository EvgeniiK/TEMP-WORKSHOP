top_limit = 20

stop = false
result = 0

while stop == false
  result += 1
  check = false
  (1..top_limit).each do |i|
    if (result % i) != 0
      check = true
      break
    end
  end
  if check == true
    next
  else
    print "Result: " + result.to_s
    stop = true
  end
end
