=begin
Add an accessor method to your MyCar class to change and view the color of your 
car. Then add an accessor method that allows you to view, but not modify, the 
year of your car.
=end

class MyCar
  
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
  
end

=begin
Notes:
 - Added the attr_accessor and attr_reader methods.
=end