# Create a class called MyCar. When you initialize a new instance or object of 
# the class, allow the user to define some instance variables that tell us the 
# year, color, and model of the car. Create an instance variable that is set to
# 0 during instantiation of the object to track the current speed of the car as 
# well. Create instance methods that allow the car to speed up, brake, and shut 
# the car off.

class MyCar
  
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
 - Based on the solution provided in the book, added puts statements for each
method to show clearly what was happening to the object.
 - Based on the solution provided in the book, added a current_speed method to
display the current speed to the user.

=end