# Override the to_s method to create a user friendly print out of your object.

class MyCar
  attr_accessor :color
  attr_reader :year
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
  
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