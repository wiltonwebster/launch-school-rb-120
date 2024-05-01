class Person
  attr_accessor :first_name, :last_name
  
  def initialize(full_name)
    parse_full_name(full_name)
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(input_name)
    parse_full_name(input_name)
  end
  
  def to_s
    name
  end
  
  private
  
  def parse_full_name(name)
    parts = name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

# Continuing with our Person class definition, what does the below code print out?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

=begin
This should output "The person's name is: " followed by a string representing
the reference to the bob object in memory. Interpolating bob does not give us
the bob object's name attribute, but a pointer to the object itself. We can fix
this by changing bob to bob.name, or we can override the to_s method in our 
Person class to return the object's name attribute.
=end

=begin
Let's add a to_s method to the class:

  def to_s
    name
  end
  
Now, what does the interpolation output?



The interpolation should now correctly output bob's name interpolated into the 
string because calling interpolation (and therefore to_s) on a Person object now
returns the Person object's name attribute. 
=end