# Circular Buffer

class CircularBuffer
  attr_reader :max_size
  attr_accessor :buffer, :num_items
  
  def initialize(max_size)
    @max_size = max_size
    @num_items = 0
    @buffer = Array.new(max_size)
  end
  
  def put(item)
    if full?
      buffer.shift
      buffer.push(item)
    else
      buffer[num_items] = item
      self.num_items += 1
    end
  end
  
  def get
    if empty?
      nil
    else
      self.num_items -= 1
      buffer.push(nil)
      buffer.shift
    end
  end
  
  def full?
    !buffer.any?(&:nil?)
  end
  
  def empty?
    buffer.all?(&:nil?)
  end
end

buffer = CircularBuffer.new(3)
puts buffer.get == nil

buffer.put(1)
buffer.put(2)
puts buffer.get == 1

buffer.put(3)
buffer.put(4)
puts buffer.get == 2

buffer.put(5)
buffer.put(6)
buffer.put(7)
puts buffer.get == 5
puts buffer.get == 6
puts buffer.get == 7
puts buffer.get == nil

buffer = CircularBuffer.new(4)
puts buffer.get == nil

buffer.put(1)
buffer.put(2)
puts buffer.get == 1

buffer.put(3)
buffer.put(4)
puts buffer.get == 2

buffer.put(5)
buffer.put(6)
buffer.put(7)
puts buffer.get == 4
puts buffer.get == 5
puts buffer.get == 6
puts buffer.get == 7
puts buffer.get == nil