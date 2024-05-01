=begin
Create a superclass called Vehicle for your MyCar class to inherit from and move
the behavior that isn't specific to the MyCar class to the superclass. Create a 
constant in your MyCar class that stores information about the vehicle that 
makes it different from other types of Vehicles.

Then create a new class called MyTruck that inherits from your superclass that 
also has a constant defined that separates it from the MyCar class in some way.
=end

class Vehicle
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  
  attr_accessor :color
  attr_reader :year
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
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
    puts "You turn off the car."
  end
  
  def current_speed
    puts "You are now going #{@speed} mph."
  end
  
  def spray_paint(color)
    self.color = color
    puts "You spray painted your car #{color}."
  end
  
  def to_s
    "My car is a #{color} #{model} from #{year}."
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
end