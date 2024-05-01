# Explain what the @@cats_count variable does and how it works. What code would
# you need to write to test your theory?

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

# @@cats_count is a class variable for the Cat class which keeps track of the
# number of Cat objects that have been initialized. Every time the initialize
# method is invoked by Cat.new, the counter is incremented by 1. In order to
# test this, we could create some cat objects, then call the class method
# self.cats_count.

p Cat.cats_count # => 0
tabby = Cat.new('tabby')
longhair = Cat.new('longhair')
p Cat.cats_count # => 2