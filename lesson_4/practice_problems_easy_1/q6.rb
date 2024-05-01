# What is the default return value of to_s when invoked on an object? Where 
# could you go to find out if you want to be sure?

# When invoked on an object whose class does not have a custom-defined to_s
# method, to_s will print the object's reference (the Class and encoding of the 
# object ID) as well as the initialized values that make up the object's state.

# This information can be found in the Object class documentation.