# We have an Oracle class and a RoadTrip class that inherits from the Oracle 
# class. What is the result of the following:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
trip.predict_the_future

# This code behaves similarly to q1, except now it's a Roadtrip object calling
# the predict_the_future method. Since that method does not exist in the 
# Roadtrip class, it is searched for and located in the Oracle class. Even 
# though the method is called from the superclass, the choices method lookup
# begins again in the Roadtrip class, so a random string is chosen from the
# Roadtrip choices.