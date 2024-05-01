# What would happen if I called the methods like shown below?

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model

=begin
(1) A new Television object called tv would be created.
(2) A NoMethodError would be thrown (no instance method called manufacturer).
(3) The model method would be executed on the tv object.
(4) The manufacturer method would be executed on the Television class.
(5) A NoMethodError would be thrown (no clss method called model).
=end