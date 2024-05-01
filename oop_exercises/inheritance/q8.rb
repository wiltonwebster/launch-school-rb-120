# Method Lookup (Part 2)

=begin
Using the following code, determine the lookup path used when invoking 
cat1.color. Only list the classes and modules that Ruby will check when 
searching for the #color method.
=end

class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color

# Cat < Animal < Object < Kernel < BasicObject
# There is no #color method defined, so Ruby exhausts the entire lookup path:
# the Cat class, the Animal class, the Object class, the Kernel module included
# in Object, and the BasicObject class.