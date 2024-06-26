# Bank Balance

# We created a simple BankAccount class with overdraft protection, that does not
# allow a withdrawal greater than the amount of the current balance. We wrote
# some example code to test our program. However, we are surprised by what we
# see when we test its behavior. Why are we seeing this unexpected output? Make
# changes to the code so that we see the appropriate behavior.

require 'pry'

class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount > 0
      success = valid_transaction?(amount)
    else
      success = false
    end

    if success
      self.balance -= amount
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def valid_transaction?(amount)
    balance - amount >= 0
  end

  private
  
  attr_writer :balance
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
                          # Actual output: $80 withdrawn. Total balance is $50.
p account.balance         # => 50

=begin
The bug is caused by expecting the balance= setter method to return a boolean.
Since setters are a type of assignment, they always return the value being
assigned, regardless of any explicit returns defined in the setter method. In
order to fix this, we should separate the setter from the validation method.
=end