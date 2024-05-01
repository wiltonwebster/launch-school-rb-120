# Start the Engine (Part 2)

=begin
Given the following code, modify #start_engine in Truck by appending 'Drive 
fast, please!' to the return value of #start_engine in Vehicle. The 'fast' in 
'Drive fast, please!' should be the value of speed.
=end

class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  attr_reader :speed
  
  def start_engine(speed)
    super() + " Drive #{speed}, please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')


