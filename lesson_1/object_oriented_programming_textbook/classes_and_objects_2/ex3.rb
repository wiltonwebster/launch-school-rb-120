# When running the following code...

class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

=begin 

We get the following error...

test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
  
Why do we get this error and how do we fix it?



We don't have a Person#name= method because our attribute method only defines a
getter method for the name attribute. If we change attr_reader to attr_accessor,
then we will have access to a setter method as well, and we would be able to use
the syntax Person.name = in order to give our Person object a new name.

=end