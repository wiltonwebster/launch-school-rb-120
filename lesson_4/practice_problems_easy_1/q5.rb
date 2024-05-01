# Which of these two classes would create objects that would have an instance 
# variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# Instance variables precede with @. The initialize method in Fruit does not 
# create any such variables, but the one in Pizza does.