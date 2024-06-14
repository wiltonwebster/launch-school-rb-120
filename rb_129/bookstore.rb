=begin
Bookstore class should contain a list of books, customers, and employees

Book class should contain title, author, ISBN, num pages, genre, price, etc

Customer class should contain title, customer ID, num books purchased, total spent
  customer should be able to Buy book
  customer class should have num customers as a class variable
    initialize should create customer ID equal to current num customers
    
    



Duck typing example:
  Customer class can have a checkout method allowing customers to check out
  Employee class can have a Cashier subclass
    Cashier class can have a checkout method allowing cashiers to check
    customers out
  These method invocations are related but do not perform the same action. This
  is duck typing because these classes share no mixin-module and no inheritance
  chain - they're just two different types of objects which have a similar
  behavior, defined specifically for each one of them.
  
=end