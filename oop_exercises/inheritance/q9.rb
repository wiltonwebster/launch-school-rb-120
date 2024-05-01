# Method Lookup (Part 3)

=begin
Using the following code, determine the lookup path used when invoking 
bird1.color. Only list the classes or modules that were checked by Ruby when 
searching for the #color method.
=end

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color

# Bird < Flyable < Animal

# The path starts with the class, then its included modules, then its super 
# class. If it were not in Animal, we would continue to the Object class.