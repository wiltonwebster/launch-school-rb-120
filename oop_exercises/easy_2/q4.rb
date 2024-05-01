# Reverse Engineering

=begin
Write a class that will display:

ABC
xyz

when the following code is run:

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

=end

class Transform
  attr_reader :data
  
  def initialize(data)
    @data = data
  end
  
  def uppercase
    data.upcase
  end
  
  def self.lowercase(data)
    data.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')