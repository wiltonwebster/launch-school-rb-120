# In the name of the cats_count method we have used self. What does self refer 
# to in this context?

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# In this context, self is used in a method name to create a Class method. The
# method can only be called on the class itself: Cat.cats_count