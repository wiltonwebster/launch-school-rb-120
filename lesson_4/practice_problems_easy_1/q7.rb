# You can see in the make_one_year_older method we have used self. What does 
# self refer to here?

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

# self is called in an instance method, so it refers to the instance of the Cat
# class which called the method. It's used in this case to distinguish between
# calling the @age setter method (age=) from the initialization of a new local
# variable called age.