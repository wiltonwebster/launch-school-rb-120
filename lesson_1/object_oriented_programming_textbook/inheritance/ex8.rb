=begin
Given the following code...

bob = Person.new
bob.hi

And the corresponding error message...

NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
from (irb):8
from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

What is the problem and how would you go about fixing it?



Person#hi appears to be a private method, which means it can only be called by
other methods within the Person class. In order to access it elsewhere, we would
either need to make hi a public method or add a public method in Person that
calls the hi method and call that method on bob instead.
=end
