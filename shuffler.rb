CARDS_AT_ONCE = ARGV[0].to_i

[:bottom_half, :top_half].each do |first_card|
  cards = (1..52).to_a
  rounds = 0
  loop do
    rounds += 1
    if first_card == :bottom_half
      half1 = cards[0..25]
      half2 = cards[26..52]
    elsif first_card == :top_half
      half1 = cards[26..52]
      half2 = cards[0..25]
    else
      raise(Exception, "first_card invalid!")
    end

    cards = []
    while(half1.length > 0)
      # Take from the first stack
      0.upto(CARDS_AT_ONCE - 1) do
        if half1.length > 0
          cards << half1.shift
        end
      end
      0.upto(CARDS_AT_ONCE - 1) do
        if half2.length > 0
          cards << half2.shift
        end
      end
    end

    if cards == cards.sort()
      break
    end
  end

  puts("It took #{rounds} rounds dropping cards from #{first_card} first!")
end
