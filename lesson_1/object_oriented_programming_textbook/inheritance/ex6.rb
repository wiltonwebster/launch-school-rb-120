=begin
Write a method called age that calls a private method to calculate the age of 
the vehicle. Make sure the private method is not available from outside of the 
class. You'll need to use Ruby's built-in Time class to help.
=end

module Haulable
  def haul_firewood
    puts "This vehicle hauls firewood."
  end
end

class Vehicle
  require 'time'
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
  
  def age
    "My #{model} is #{years_old} years old."
  end
  
  private
  
  def years_old
    Time.now.year - year
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

car = MyCar.new(2005, "white", "model")
puts car.age
puts car.years_old