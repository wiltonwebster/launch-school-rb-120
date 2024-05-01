# If we have the class below, what would you need to call to create a new
# instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# In order to create a new Bag object, we would need to call Bag.new and pass
# in two arguments corresponding to the object's color and material. If we fail
# to pass the correct number of args, the initialize method will throw an
# argument exception.

bag = Bag.new('red', 'burlap')