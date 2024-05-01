=begin
Create a module that you can mix in to ONE of your subclasses that describes a 
behavior unique to that subclass.
=end

module Haulable
  def haul_firewood
    puts "This vehicle hauls firewood."
  end
end

class Vehicle
  @@num_vehicles = 0

  attr_accessor :color
  attr_reader :year, :model
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@num_vehicles += 1
  end
  
  def speed_up(acceleration)
    @speed += acceleration
    puts "You push the gas and accelerate #{acceleration} mph."
  end
  
  def brake(deceleration)
    @speed -= deceleration
    puts "You push the brake and decelerate #{deceleration} mph."
  end
  
  def shut_off
    @speed = 0
    puts "You turn off the vehicle."
  end
  
  def current_speed
    puts "You are now going #{@speed} mph."
  end
  
  def spray_paint(color)
    self.color = color
    puts "Your #{color} paint job looks great!"
  end
  
  def self.how_many_vehicles
    puts "There are #{@@num_vehicles} vehicles."
  end
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  
  def to_s
    "My car is a #{color} #{model} from #{year}."
  end
end

class MyTruck < Vehicle
  include Haulable
  NUMBER_OF_DOORS = 2
  
  def to_s
    "My truck is a #{color} #{model} from #{year}."
  end
end