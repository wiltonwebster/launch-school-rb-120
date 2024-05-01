# What Will This Do?

# What will the following code print?

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata

=begin
The Something object created on line 19 and stored in the local variable thing
stores the string 'Hello' in its instance variable @data. On line 20, we call 
the class method dupdata, which returns 'ByeBye', and we pass that to the puts
method. We then call the instance method dupdata on thing, which returns the
value of @data duplicated, or "HelloHello". We then pass that to the puts method
as well. Therefore, the input should be:

ByeBye
HelloHello
=end