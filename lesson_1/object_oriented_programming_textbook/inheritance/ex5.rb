=begin
Move all of the methods from the MyCar class that also pertain to the MyTruck 
class into the Vehicle class. Make sure that all of your previous method calls 
are working when you are finished.
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

lumina = MyCar.new(1997, 'white', 'chevy lumina')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.shut_off
MyCar.gas_mileage(13, 351)
lumina.spray_paint("red")
puts lumina
puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors