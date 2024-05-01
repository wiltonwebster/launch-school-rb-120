# Fix the Program - Flight Data

class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# There is nothing technically incorrect about this class, but the definition 
# may lead to problems in the future. How can this class be fixed to be 
# resistant to future problems?


# The accessor method for database_handle is unnecessary, since users should
# have no need to access that information. We should delete it.

# From the solution: "By making access to @database_handle easy, someone may use
# it in real code. And once that database handle is being used in real code, 
# future modifications to the class may break that code. You may even be 
# prevented from modifying your class at all if the dependent code is of greater
# concern.
