# What is the result of executing the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
oracle.predict_the_future

=begin
Calling Oracle.new creates a new Oracle object and stores it in the variable
oracle. Calling the predict_the_future method returns a string that concatenates
"You will " and the return value of choices.sample. The choice method returns an
array of strings, and the sample method then returns one of those strings. The
final result will be to return a prediction string - for example: "You will eat
a nice lunch".
=end