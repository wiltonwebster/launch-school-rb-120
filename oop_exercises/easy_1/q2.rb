# What's the Output?

=begin
What output does this code print? Think about any undesirable effects occurring 
due to the invocation on line 17. Fix this class so that there are no surprises
waiting in store for the unsuspecting developer.
=end

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name


=begin
The code uses the destructive version of upcase on @name. Since it is unlikely
that we will have a need to keep this uppercase version of @name, we should just
use the non-destructive version in the interpolation instead.
=end

def to_s
  "My name is #{@name.upcase}."
end