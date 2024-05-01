# How do you find where Ruby will look for a method when that method is called?
# How can you find an object's ancestors?

# What is the lookup chain for Orange and HotSauce?

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# Call the ancestors method on any class to see that class's method lookup 
# path. The path will traverse the class, its modules, the superclass and its
# modules, all the way back to the Object class, Kernel module, and BasicObject
# class.

# Orange: Orange > Taste > Object > Kernel > BasicObject
# HotSauce: HotSauce > Taste > Objecet > Kernel > BasicObject
