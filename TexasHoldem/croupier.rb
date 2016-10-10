class Croupier
  def look(cards)
    @cards = sort_cards(cards)
    @win = []
    @straight = check_straight(@cards)
    @flush = check_flush(@cards)
    @four_of_a_kind = check_four_of_a_kind(@cards)
    @full_house = check_full_house(@cards)
    if @straight != false
      straight_flush = check_straight_flush(@straight)
    else
      straight_flush = false
    end

    if @four_of_a_kind != false
      @win = @four_of_a_kind
    end

  end

  def show_cards
    if @win.length > 0
      @cards.each do |card|
        puts card
      end
      puts "=========================="
      @win.each do |w|
        puts w
      end
      puts "=========================="
      puts "=========================="
    end
  end

  private

  def check_full_house(cards)
    kinds = parse_cards(cards).sort{|x, y| y[1] <=> x[1]}
    counter = 1
    full_house = true
    setups = []
    dec_ones = 1
    kinds.each do |kind|
      if counter == 1
        if kind[1] != 3
          full_house = false
        else
          setups.push(kind)
        end
      end
      if counter == 2
        if kind[1] < 2
          if dec_ones == 1
            full_house = false
          end
        elsif kind[1] == 3
          setups.push(kind)
        else
          setups.push(kind)
          counter -= dec_ones
          dec_ones = 0
        end
      end
      break if counter == 2
      counter += 1
    end
    if full_house == true
      if setups.length == 2 && setups[1][1] == 3
        puts '3 & 3'
      elsif setups.length == 2 && setups[1][1] == 2
        puts '3 & 2'
      else
        puts '3 & 2 & 2'
      end
    else
      return false
    end
  end

  def check_four_of_a_kind(cards)
    kinds = parse_cards(cards)
    max = {'type' => '', 'size' => 0}
    kinds.each do |kind|
      if kind[1] > max['size']
        max['size'] = kind[1]
        max['type'] = kind[0].to_i
      end
    end
    if max['size'] == 4
      win = []
      cards.each do |card|
        if card['type'] == max['type']
          win.push(card)
        end
      end
      return win
    else
      return false
    end
  end

  def check_royal(cards)
    if cards[0]['type'] == 14
      return true
    else
      return false
    end
  end

  def check_straight_flush(cards)
    straight_flush = true
    color = @max['type']
    (0..4).each do |i|
      if cards[i]['color'] != color
        replace = false
        @cards.each do |card|
          if card['type'] == cards[i]['type'] && card['color'] == color
            replace = true
            cards[i]['color'] = color
          end
        end
        if replace == false
          straight_flush = false
        end
      end
    end
    if straight_flush == true
      return cards
    else
      return false
    end
  end

  def check_flush(cards)
    colors = {'H' => 0, 'D' => 0, 'C' => 0, 'S' => 0}
    cards.each do |card|
      colors[card['color']] += 1
    end
    @max = {'size' => 0, 'type' => ''}
    colors.each do |color|
      if color[1] > @max['size']
        @max['size'] = color[1]
        @max['type'] = color[0]
      end
    end
    if @max['size'] >= 5
      counter = 0
      win = []
      cards.reverse.each do |card|
        if card['color'] == @max['type']
          win.push(card)
          counter += 1
        end
        if counter == 5
          return win
        end
      end
    else
      return false
    end
  end

  def check_straight(cards)
    win = []
    counter = 0
    (1..(cards.length - 1)).to_a.reverse.each do |i|
      if (cards[i]['type'] - 1) == cards[i - 1]['type']
        counter += 1
        win.push(cards[i])
        cards[i]['straight'] = true
      else
        cards[i]['straight'] = false
        counter = 0
      end
      if counter == 4
        win.push(cards[i - 1])
        return win
      end
    end
    if cards[1]['straight'] == true
      win.push(cards[0])
      cards[0]['straight'] = true
    else
      cards[0]['straight'] = false
      if cards[2]['straight'] == true
        win.push(cards[1])
      end
    end

    if win.length >= 5
      after_check = check_straight(win.reverse)
      if after_check != false
        return after_check
      else
        return false
      end
    else
      return false
    end
  end

  def parse_cards(cards)
    kinds = {}
    cards.each do |card|
      if kinds.include?(card['type'].to_s)
        kinds[card['type'].to_s] += 1
      else
        kinds[card['type'].to_s] = 1
      end
    end
    return kinds
  end

  def sort_cards(cards)
    cards.sort{|x, y| x['type'] <=> y['type']}
  end

end
