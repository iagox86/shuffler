SUITS = ['S', 'D', 'C', 'H']
RANKS = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
CARDS = SUITS.product(RANKS).map { |e| e.reverse.join() }

def print_stack(stack)
  stack = stack.reverse()
  print stack[0..2].map { |i| CARDS[i-1] }.join(',')
  print ' || ' + CARDS[stack[25]-1] + ',' + CARDS[stack[26]-1] + ' || '
  print stack[49..52].map { |i| CARDS[i-1] }.join(',')
end

def usage()
  puts("Usage: ruby ./shuffler.rb <stack_size> [top|bottom]")
  exit()
end

def mix(count, half1, half2)
  cards = []
  while(half1.length > 0)
    1.upto(count) do
      if half1.length() > 0
        cards << half1.shift
      end
    end
    1.upto(count) do
      if half2.length() > 0
        cards << half2.shift
      end
    end
  end

  return cards
end

if ARGV[0].nil?
  usage()
end

CARDS_AT_ONCE = ARGV[0].to_i
if ARGV[1].nil?
  HALVES = [:bottom_half, :top_half]
elsif ARGV[1] == 'top'
  HALVES = [:top_half]
elsif ARGV[1] == 'bottom'
  HALVES = [:bottom_half]
else
  usage()
end

HALVES.each do |first_card|
  cards = (1..52).to_a

  rounds = 0
  loop do
    print "Round #{rounds}: "
    print_stack(cards)

    rounds += 1

    if first_card == :bottom_half
      half1 = cards[0..25]
      half2 = cards[26..52]
    elsif first_card == :top_half
      half1 = cards[26..52]
      half2 = cards[0..25]
    end

    cards = mix(CARDS_AT_ONCE, half1, half2)

    if cards == cards.sort()
      break
    end
    STDIN.gets()
  end

  puts("It took #{rounds} rounds dropping cards from #{first_card} first!")
end
