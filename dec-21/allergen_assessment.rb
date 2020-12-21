require 'set'

class AllergenAssessment
  attr_accessor :file
  def initialize(file_name)
    @file = File.open(file_name).read.split("\n")
  end

  def part_one_answer
    excluded = all_ingredients - allergen_map.values.to_set
    pairs.reduce(0) do |sum, pair|
      sum + pair[0].count { |ingredient| excluded.include?(ingredient) }
    end
  end

  def part_two_answer
    allergen_map.sort_by { |allergen, _| allergen }
      .map { |elt| elt[1] }
      .join(",")
  end

  def allergen_map
    @allergen_map ||= begin
      map = Hash.new
      while map.size != all_allergens.size
        all_allergens.each do |allergen|
          next if map.key?(allergen)
  
          overlap = all_ingredients.clone
          map.values.each do |value|
            overlap = overlap.delete(value)
          end
  
          pairs.each do |ingredients, allergens|
            if allergens.include?(allergen)
              overlap = overlap.intersection(ingredients.to_set)
            end
          end

          if overlap.size == 1
            map[allergen] = overlap.first
          end
        end
      end
      map
    end
  end

  def pairs
    @pairs ||= begin
      list = []
      file.each do |line|
        ingredients, allergens = line.split(" (")
        ingredients = ingredients.split(" ")
        allergens = allergens.gsub("contains ", "")
        allergens = allergens.gsub(")", "")
        allergens = allergens.split(", ")
        list << [ingredients, allergens]
      end
      list
    end
  end

  def all_allergens
    @all_allergens ||= begin
      set = Set.new
      file.each do |line|
        _, allergens = line.split(" (")
        allergens = allergens.gsub("contains ", "")
        allergens = allergens.gsub(")", "")
        allergens = allergens.split(", ")
        set.merge(allergens)
      end
      set
    end
  end

  def all_ingredients
    @all_ingredients ||= begin
      set = Set.new
      file.each do |line|
        ingredients, _ = line.split(" (")
        ingredients = ingredients.split(" ")
        set.merge(ingredients)
      end
      set
    end
  end
end

aa = AllergenAssessment.new('input.txt')
puts "Part 1: " + aa.part_one_answer.to_s
puts "Part 2: " + aa.part_two_answer.to_s
