# If we call Hello.hi we get an error message. How would you fix this?

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# We could create a class method so we can call hi on the class itself, or we
# could create a Hello object and call hi on that (Hello.new.hi).

# Solution notes that if we created a hi class method, we could not use greet,
# since greet is an instance method.