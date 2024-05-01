# If we have these two methods in the Computer class, what is the difference in
# the way the code works?

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    self.template
  end
end

# There is no difference. Calling self.template is a redundant but equally
# valid way to use the getting method provided by accessor.