# Method Lookup (Part 1)

=begin
Using the following code, determine the lookup path used when invoking 
cat1.color. Only list the classes that were checked by Ruby when searching for 
the #color method.
=end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
cat1.color

# Cat > Animal
# Ruby looks for a color method in the Cat class but can't find one. It then 
# looks in Animal, finds one, and invokes it. Otherwise, it would have continued
# up the path and checked in Object.