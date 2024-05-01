# Pet Shelter

# Write the classes and methods that will be necessary to make this code run.

class Shelter
  def initialize
    @adoption_list = {}
  end
  
  def adopt(owner, pet)
    owner.add_pet(pet)
    update_adoption_list(owner, pet)
  end
  
  def update_adoption_list(owner, pet)
    if @adoption_list.key?(owner)
      @adoption_list[owner] << pet
    else
      @adoption_list[owner] = [pet]
    end
  end
  
  def print_adoptions
    @adoption_list.each do |owner, pet_list|
      puts "#{owner.name} has adopted the following pets:"
      pet_list.each { |pet| puts pet }
      puts ""
    end
  end
end

class Pet
  def initialize(animal, name)
    @animal = animal
    @name = name
  end
  
  def to_s
    "a #{@animal} named #{@name}"
  end
end

class Owner
  attr_reader :name, :pets
  
  def initialize(name)
    @name = name
    @pets = []
  end
  
  def add_pet(pet)
    pets << pet
  end
  
  def number_of_pets
    pets.size
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

=begin
Intended output:

P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
=end