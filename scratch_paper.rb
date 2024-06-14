class Cat
  def initialize(name)
    @name = name
  end

  def what_am_i?
    self
  end
end

fluffy = Cat.new('Fluffy')
p fluffy.what_am_i? # what is output?


#####


class Cat
  def initialize(name)
    @name = name
  end

  def what_am_i?
    self
  end
end

class Persian < Cat; end

fluffy = Persian.new('Fluffy')
p fluffy.what_am_i? # what is output? Is it different from the previous example? Why?


####

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def what_am_i?
    self
  end

  def who_am_i?
    name
  end
end

class Persian < Cat; end

fluffy = Persian.new('Fluffy')
p fluffy.who_am_i? # Fluffy