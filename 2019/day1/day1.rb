class FuelCalculator
  def calculate(mass)
    fuel_req = 0
    curr_req = from_mass(mass)
    while curr_req > 0
      fuel_req += curr_req
      curr_req = from_mass(curr_req)
    end
    { fuel: fuel_req }
  end

  private

  def from_mass(mass)
    mass / 3 - 2
  end
end

class InputReader
  attr_accessor :vals
  def self.read_input(file_name)
    @vals = File.read(file_name).split.map(&:to_i)
  end
end

class RequirementCalculator
  attr_accessor :masses, :calculators
  def initialize(masses, calculators)
    @masses = masses
    @calculators = calculators
  end

  def requirements
    calculators.map do |calculator|
      reqs = masses.map { |mass| calculator.calculate(mass) }
      reqs.inject do |memo, req|
        memo.merge(req) { |_, old_v, new_v| old_v + new_v }
      end
    end
  end
end

masses = InputReader.read_input('input.txt')
requirements = [FuelCalculator.new]
rc = RequirementCalculator.new(masses, requirements)
puts "requirements: " + rc.requirements.to_s

