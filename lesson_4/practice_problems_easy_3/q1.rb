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

# What will each of these do?

hello = Hello.new
hello.hi

hello = Hello.new
hello.bye

hello = Hello.new
hello.greet

hello = Hello.new
hello.greet("Goodbye")

Hello.hi

=begin
The Hello and Goodbye classes both inherit from Greeting and can access the
greet instance method. In each case:
(1) The Hello object hello calls the hi method, outputting "Hello".
(2) The Hello object hello calls the bye method, which is not defined and
    throws a NoMetodError (there is no bye method in the lookup path).
(3) The Hello object hello calls the greet method without an argument, which
    throws an ArgumentError (1 excepted, 0 given).
(4) The Hello object hello calls the greet method with "Goodbye" outputting
    "Goodbye".
(5) The Hello class calls the hi method, which is not defined and throws a
    NoMethodError (there is no class method called hi).
=end