=begin

Benefits of OOP:
  Limited interdependency
    Objects don't necessarily need to know about the states or behaviors of 
    other types of objects. Changes can be made in large codebases without the
    risk of large ripple effects across the entire program.
  Encapsulation
    Classes and Modules encapsulate certain data and operations (instances and
    their methods) into subsets with well-defined boundaries. Data are protected
    from interaction with other parts of the program except through narrowly
    defined interfaces (methods) which allow intentional access.
    Encapsulation allows us to create a public interface - a set of methods
    which define the behaviors and states that are accessible to the rest of the
    program. All other methods and states for an object are hidden.
    In general, try to minimize the number of public methods to keep the public
    interface simple and clean. Any method that can be private/public should be
    made so.
  Polymorphism
    Different types of data (objects) can respond to the same interface (method)
    so long as those data types have a defined method by that name. 
    Polymorphism allows us to reuse method names in logical ways, making code
    more human-readable.
    How can polymorphism be implemented?
      Inheritance: Different classes might inherit the same behavior from a 
        common superclass. Thus, objects of different types can respond to a
        common method invocation. We can also override the method in subclasses
        if specific needs arise. The text gives the example of Animal superclass
        with a move method with an empty definition. All animal subtypes inherit
        this, so immobile animal objects have no action for move. But we can also
        define specific move methods in subclasses such as Cat and Fish which 
        might have custom move methods that show that a Cat walks or a Fish swims.
        Mixin modules can also define behaviors needed in some places but not
        others within an inheritance hierarchy.
      Duck Typing: Polymorphism that is not born of inheritance. Multiple 
        classes might contain the same behavior even if they aren't part of an
        inheritance hierachy. For instance, the text shows a Wedding class with
        Chef, Decorator, and Musician classes. Each person class contains a 
        prepare_wedding method, since each has a hand in preparing some aspect
        of a wedding. But the implementation of each will be different.
    Polymorphism does not include methods that have the same name but no
    intended relation between the actions. For example, a Circle class and a
    Blinds class might each have a draw method. But those methods share no
    contextual similarities, so they are not polymorphic.
  Inheritance
    Classes can inherit behaviors from existing classes, creating hierarchies.
    Classes can also inherit behaviors from modules, allowing for Ruby's form of
    Multiple Inheritance.

Structures:
  Classes
    A class defines a set of potential states and behaviors. A class works as a
    template for creating objects.
  Objects
    An object is an instance of a class. Most things in Ruby are objects, but
    not all of them (e.g. methods, blocks, variables, control expressions).
    Two objects of the same class will have the same template - that is, the 
    same set of behaviors and states available to them. However, they will not
    necessarily have the same states (instance variables), and they will always
    be distinct objects with different object IDs.
  Modules (Mixins)
    A module is a collection of behaviors (methods). Unlike classes, it is not
    possible to create an object from a module.
    Modules can be included in classes using the 'include' reserved word. This
    allows for a form of Multiple Inheritance, if we need to inherit more
    behaviors than are available in a class's superclass.
    Modules cannot inherit from other modules.

Method Lookup Path:
  Use the ancestors method to see the full lookup path for any class name. If
  you call ancestors on a module, it will return only the name of the module,
  since Modules do not inherit from anywhere and cannot be inherited.
  The path will show the class itself, then any mixed-in modules in reverse
  order of their declarations within the class (last to first), then the first
  superclass, then its mixed-in modules, and so on until there are no more
  superclasses. This path will always terminate with Object, Kernel, and
  BasicObject, since all classes inherit from the Object class, which includes
  the Kernel module and finally inherits from the BasicObject class.

Scope:
  Instance Variables
    Scoped at the object (instance) level. Each object has access to its own
    state - it will only have access to other objects' states if those objects
    are explicitly passed to it. It might also have restricted access to other
    objects depending on certain accessor behaviors being private / protected.
    Instance variable names always precede with @. Instance variables are 
    accessible within instance methods. 
    Trying to access an uninitialized instance variable will yield nil, rather
    than a NameError.
  Instance Methods
    Methods defined within a class (without self). These methods are available
    to be called on instances of the class (objects), subject to restrictions on
    the method's access (private / protected).
  Class Methods
    Class methods are methods to be called directly on the Class. A Class's 
    class methods cannot be called on instances of that Class.
    Class method definition names are prepended with self to deonte that they
    are called directly on the class (in the class scope where methods are being
    defined, self would refer to the class itself).
  Class Variables
    Class variables are scoped at the class level and prepend with @@. Class
    variables can be accessed by class methods or instance methods, provided
    they have already been initialized.
  Self
    The reserved word "self" has different meanings based on the scope where it
    is invoked. Inside a class but outside an instance method definition, self 
    refers to the class itself. That is why self.method_name refers to a class
    method - it is equivalent to class_name.method_name. If we were simply to
    add "puts self" somewhere in a class definition, the console would show the
    class name, since self refers to the class and puts causes Module#to_s to be
    called, which converts the name of a Class or Module to a String object.
    If self is invoked inside an instance method, it refers to the calling
    object. That is, it refers to whatever object called the instance method.
    If self is referenced in a module, it behaves the same way as it would in a
    class. If self is referenced in an instance method in a module, it still 
    refers to the calling object.
    If self is invoked outside of any class or module, it refers to the Main 
    scope. For instance, "puts self" outputs "main".
  Constants
    Constants are defined by beginning a variable name with a capital letter.
    Commonly, the entire name of a constant will be uppercased, but that does 
    not have to be the case (for instance, Class names are constants).
    Constants have Lexical scope: Ruby will search for a constant in the 
    surrounding structure first, then traverse the method lookup chain, ending
    in Main. Specifically, it looks in the scope in which the constant was 
    invoked, then in the surrounding scope, then up the lookup chain, then in
    main scope.

Inheritance:
  Inheritance is a paradigm that allows classes to inherit behaviors from other
  classes. Inheritance does not affect states - only behaviors.
  Class Inheritance
    We can create hierarchies of classes by subclassing one class from another.
    The subclass is said to inherit from the superclass. Ruby does not support
    multiple inheritance, so hierarchies in Ruby are linear. We can also 
    override an inherited method in a subclass by writing a new definition for
    it. This is standard practice (to_s is an example, as are many fake 
    operators).
    The Super keyword:
      If you invoke super inside an instance method, Ruby moves up the lookup
      path for the next occurrence of the same method name to invoke.
      Super acts as a method and can take arguments and give a meaningful 
      return value. If the original method is passed an argument list that does
      not match the argument list that needs to be passed to super, you must
      explicitly pass the correct argument list to super, even if the list is
      empty: super().
  Interface Inheritance
    Classes can also inherit behaviors from modules, called interface 
    inheritance. This is Ruby's substitute for multiple inheritance. A class can
    inherit from as many modules as we need. Modules typically describe a
    certain type of behavior, since those modules describe behaviors that have
    been grouped together for the purpose of being included in classes.
    In order to use a mix-in module, the module must be included (keyword) in 
    the desired class.
  Relationships
    If two classes have an "is-a" relationship (that is, one is a type of the
    other), then those classes should be in a class inheritance hierarchy.
    If two classes do not have an "is-a" relationship, but their objects have
    certain "has-a" relationships, then those objects share certain behaviors
    and should probably both inherit those behaviors from the same interface 
    (module).

Collaboration:
  Objects that are stored as state within another object are also called 
  "collaborator objects".
  Composition
    An object can be composed of many other objects that make up its state. For
    example, we can define a Car class and an Engine class. When we instatiate a
    new Car object, we can also instantiate a new Engine object, where the
    engine object is part of the car object's state. These objects collaborate,
    and the car object is a composition of other custom-defined objects. We say
    that Car and Engine have a "has-a" relationship (a Car has an Engine).
  Aggregation
    An object can contain other objects in a less tightly-coupled relationship.
    For instance, we can define a Car class and a Passenger class. The car
    object may or may not interact with passenger objects, depending on the car
    object's state. The passenger objects do not necessarily depend on the 
    existence of a car object for their own existence. Aggregations can also
    have a "has-a" relationship (a Car can have Passengers).
  When working with collaborator objects, make sure to keep track of which types
  of objects are being used where. For instance, do not confuse a Pet object
  with an array of Pet objects. Similarly, do not attempt to call a method for
  each Pet in a Pets array if not all pets will have a polymorphic way to 
  respond to that invocation.

More uses for Modules:
  Namespacing
    Modules can be used to group together sets of related classes. This logic 
    appears to be similar to class inheritance, but we can make the top level a 
    module instead of a class if we do not need to create instances at that level.
    Namespacing also inherently reduces the risk of names colliding with names in
    other parts of the program. For instance if Dog class and Cat class are both
    in the Mammal module, we can write Mammal::Dog or Mammal::Cat instead of just
    Dog or Cat. 
  Containers
    Modules can also house methods that have no apparent place in the existing
    code. That is, rather than trying to fit methods into classes where they
    don't belong, we can extract those methods into modules to make the structure
    more logical. It also allows us to house methods that don't require an
    instance (module methods are like class methods, but for modules.)

Accessor Methods:
  Getter methods allow us to access the value stored in an instance variable.
  Setter methods allow us to alter the value stored in an instance variable.
  Getters and Setters can be included with the syntactic sugar of attr_reader
  and attr_writer, followed by a symbol of the intended method name. For both
  in one, attr_accessor can be used.
  Note that setter methods must contain '=' at the end of their method names.
  This allows us to use syntatic sugar like: Object.name = "Name" instead of
  the more terse Object.name=("Name").
  In order to call a setter method, prepend the method name with self. This
  tells Ruby that we are referring to self's (the calling object's) method
  with that name, rather than initializing a new local varaible.
  Prepending self could also be used with getter methods, though it is not
  necessary. Since getters do not share a syntax with anything (such as new
  local variable initialization and assignment), there is no ambiguity.
  Setter methods always return the value passed in as an argument, regardless 
  of what is written in the method. Explicit and implicit returns for any 
  other value will be ignored.

Data Protection / Access Control:
  Public Methods
    All public methods are available inside and outside the class. These methods
    comprise the class's interface. By default, unless otherwise specified, all
    methods in a class or module will be public.
  Private Methods
    By using the Private keyword, we can define a set of methods in a class or
    module as private - accessible within the class but not outside the class
    (i.e. not part of the class's interface). Private instance methods are only
    available to self (the calling object).
  Protected Methods
    By using the Protected keyword, we can define a set of methods as protected.
    These methods are not available outside the class but can be invoked by any
    instance of the class within the class definition (as opposed to only by 
    self, which is the characteristic difference between private and protected).
    A common use case for protected is to compare aspects between two instances
    of a class. The method that does the comparison is public, while the helper
    method that accesses an object's state is protected. That way, data about
    the object cannot be accessed publicly, but can still be accessed by another
    object as long as it's in the same class.
  
String Conversion (to_s method)
  Every class uses to_s for puts and string interpolation (not p). Most classes
  define a custom version of to_s, since the default behavior (from Object#to_s)
  is to print out the ID and state of the object. By overriding this with a 
  version of to_s specific to our class, we can define our own criteria for what
  should be printed when a custom object is interpolated or printed.
  The custom to_s method must always return a string. If to_s does not return a
  String object, Ruby will look up the inheritance chain for a different to_s
  method to use.


=end