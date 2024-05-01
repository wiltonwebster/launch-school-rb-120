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
  
  private
  
  def parse_full_name(name)
    parts = name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

# Using the class definition from q3, let's create a few more objects.

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

# If we're trying to determine whether the two objects contain the same name, 
# how can we compare the two objects?

p bob.name == rob.name # => true
p bob == rob # => false

=begin
Notes: 
 - The string comparison operation returns true because == is a String method 
which compares if two strings are made up of the same characters. Since there is
no == method defined for Person, the Person objects use the BasicObject version 
of the == method, which only returns true if two references point to the same 
object.
=end