# Which one of these is a class method (if any) and how do you know? How would
# you call a class method?

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# The self prefix in a method name denotes it as a Class method, since it is 
# called on self (the class) instead of an instance. self.manufacturer is a 
# class method, while model is an instance method.