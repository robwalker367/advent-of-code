require 'set'

# TODO: refactor all of this!
class CrabCombat
  attr_accessor :cards_p1, :cards_p2, :rounds
  def initialize(file_name)
    file = File.open(file_name).read.split("\n\n")
    @cards_p1 = file[0].split("\n")[1..].map(&:to_i)
    @cards_p2 = file[1].split("\n")[1..].map(&:to_i)
    @rounds = Set.new
  end

  def part_one_answer
    result = game_result
    if !result[:cards_p1].empty?
      calculate_score(cards_p1)
    else
      calculate_score(cards_p2)
    end
  end

  def part_two_answer
    result = rec_combat_game(cards_p1, cards_p2)
    if result[:winner] == :p1
      calculate_score(result[:cards_p1])
    else
      calculate_score(result[:cards_p2])
    end
  end

  def rec_combat_game(cards_p1, cards_p2)
    while !cards_p1.empty? && !cards_p2.empty?
      if rounds.include?([cards_p1, cards_p2])
        return { winner: :p1, cards_p1: cards_p1 }
      end
      rounds.add([cards_p1, cards_p2])
      p1_card, p2_card = cards_p1.shift, cards_p2.shift
      if p1_card <= cards_p1.size && p2_card <= cards_p2.size
        result = rec_combat_game(cards_p1.clone[0..p1_card-1], cards_p2.clone[0..p2_card-1])
        if result[:winner] == :p1
          cards_p1.append(p1_card, p2_card)
        else
          cards_p2.append(p2_card, p1_card)
        end
      else
        if p1_card > p2_card
          cards_p1.append(p1_card, p2_card)
        elsif p2_card > p1_card
          cards_p2.append(p2_card, p1_card)
        else
          raise "Found a tie"
        end
      end
    end
    if cards_p2.empty?
      return { winner: :p1, cards_p1: cards_p1 }
    else
      return { winner: :p2, cards_p2: cards_p2 }
    end
  end


  def calculate_score(cards)
    cards.reverse
      .each_with_index
      .map { |card, index| card * (index+1) }
      .sum
  end

  def game_result
    while !cards_p1.empty? && !cards_p2.empty?
      p1_card, p2_card = cards_p1.shift, cards_p2.shift
      if p1_card > p2_card
        cards_p1.append(p1_card, p2_card)
      elsif p2_card > p1_card
        cards_p2.append(p2_card, p1_card)
      else
        raise "Found a tie"
      end
    end
    { cards_p1: cards_p1, cards_p2: cards_p2 }
  end
end

cc1 = CrabCombat.new("input.txt")
puts "Part 1: " + cc1.part_one_answer.to_s

cc2 = CrabCombat.new("input.txt")
puts "Part 2: " + cc2.part_two_answer.to_s
