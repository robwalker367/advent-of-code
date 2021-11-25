require 'set'

# TODO: refactor all of this!
class DockingData
  attr_accessor :file, :mem, :current_mask
  def initialize(file_name)
    @file = File.open(file_name).read.split("\n")
    @mem = Hash.new(0)
    @current_mask = 0
  end

  def part_one_answer
    current_mask = ''
    file.each do |line|
      cmd, elt = line.split(" = ")
      if cmd == "mask"
        current_mask = elt
      else
        mem_address = cmd.tr('^0-9', '').to_i
        mem[mem_address] = masked_num(current_mask, elt.to_i)
      end
    end
    mem.values.sum
  end

  def part_two_answer
    mem = Hash.new(0)
    current_mask = ''
    file.each do |line|
      cmd, elt = line.split(" = ")
      if cmd == "mask"
        current_mask = elt
      else
        mem_address = cmd.tr('^0-9', '').to_i
        mask_ones = current_mask.gsub('X', '0').to_i(2)
        masked_addr = mem_address.to_i | mask_ones
        x = masked_addr.to_s(2)
        x = ('0' * (current_mask.length - x.length)) + x
        addrs = Set[]
        find_possible_addresses(addrs, current_mask, x)
        addrs.each do |addr|
          mem[addr] = elt.to_i
        end
      end
    end
    mem.values.sum
  end

  def find_possible_addresses(addrs, mask, addr)
    if !mask.include?('X')
      addrs.add(addr.to_i(2))
    else
      addr1, addr2, mask = addr.clone, addr.clone, mask.clone
      x_index = mask.index('X')
      addr1[x_index] = '1'
      addr2[x_index] = '0'
      mask[x_index] = addr.clone[x_index]
      find_possible_addresses(addrs, mask, addr1)
      find_possible_addresses(addrs, mask, addr2)
    end
  end

  def masked_num(mask, num)
    mask_ones = mask.gsub('X', '0').to_i(2)
    mask_zeros = mask.gsub('X', '1').to_i(2)
    (num | mask_ones) & mask_zeros
  end
end

dd = DockingData.new('input.txt')
puts "Part 1: " + dd.part_one_answer.to_s
puts "Part 2: " + dd.part_two_answer.to_s