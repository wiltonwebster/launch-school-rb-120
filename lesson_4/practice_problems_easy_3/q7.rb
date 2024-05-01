# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high" + 
    "and a color of green"
  end

end

# The setter and getter methods provided by the accessor method do not appear to
# be used anywhere (though they could potentially be invoked elsewhere). The
# explicit return in the information class method is also unnecessary.