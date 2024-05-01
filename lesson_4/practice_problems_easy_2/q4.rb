# What could you add to this class to simplify it and remove two methods from 
# the class definition while still maintaining the same functionality?

class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

# The method has explicit getter and setter functions. These can be replaced by
# attribute reader and writers, or simply by an accessor. 

# We can also change @type to type in the describe_type method so that we are
# calling the getter method instead of directly referencing the instance var.