=begin
Alan created the following code to keep track of items for a shopping cart 
application he's writing.

Alyssa looked at the code and spotted a mistake. "This will fail when 
update_quantity is called", she says.

Can you spot the mistake and how to address it?
=end

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# The update_quantity method is initializing a new quantity variable rather than
# updating the @quantity instance variable. Alan should change quantity to 
# @quantity or self.quantity (and then add a setter method for quantity).