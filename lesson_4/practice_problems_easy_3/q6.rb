# In the make_one_year_older method we have used self. What is another way we 
# could write this method so we don't have to use the self prefix?

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# Instead of using the self prefix to disambiguate the setter method, we could
# simply call the @age variable itself: @age += 1