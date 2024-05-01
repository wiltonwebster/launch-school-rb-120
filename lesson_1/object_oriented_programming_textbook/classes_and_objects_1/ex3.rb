=begin
You want to create a nice interface that allows you to accurately describe the 
action you want your program to perform. Create a method called spray_paint that 
can be called on an object and will modify the color of the car.
=end

class MyCar
  
  attr_accessor :color
  attr_reader :year, :model
  
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

=begin
Notes:
 - Added the spray_paint instance method. The method uses the self keyword to
call the setter method for color so we can assign the new color value to our 
instance variable @color.
=end

car = MyCar.new(2005, "gray", "s80")
car.spray_paint("red")