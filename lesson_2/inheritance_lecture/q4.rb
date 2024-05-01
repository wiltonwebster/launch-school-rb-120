=begin
What is the method lookup path and how is it important?

The method lookup path is the hierarchy that describes the order in which Ruby
looks through classes and modules for method invocations. The lookup path starts
in the current class, then to mixed in modules, then the superclass, then its 
mixed in modules, and so on until all superclasses are exhausted. This allows us
to create hierarchies of classes and inherit behaviors from classes that already
exist. It also allows us to take advantage of polymorphism - that is, we can 
overwrite more generalized methods in superclasses with more specialized methods
in subclasses. Since the more specific classes come earlier in the lookup path,
the most specific version of the polymorphism will always be selected.
=end