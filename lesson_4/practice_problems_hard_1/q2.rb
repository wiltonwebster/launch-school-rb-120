=begin
Building on the prior vehicles question, we now must also track a basic 
motorboat. A motorboat has a single propeller and hull, but otherwise behaves
similar to a catamaran. Therefore, creators of Motorboat instances don't need to
specify number of hulls or propellers. How would you modify the vehicles code to
incorporate a new Motorboat class?
=end

module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Boat
  include Moveable
  
  attr_reader :hull_count, :propeller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end
end

class Catamaran < Boat
end

class Motorboat < Boat
  def initialize(fuel_efficiency, fuel_capacity)
    super(1, 1, fuel_efficiency, fuel_capacity)
  end
end