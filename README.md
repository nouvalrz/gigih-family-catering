# Final Project Assignment Backend Generasi GIGIH 2.0

Build an API based catering management application using Ruby on Rails.

# Use Case
1. The owner adds a menu item with the following terms:
    * Menu names cannot be duplicates
    * Price cannot be less than 0.01
    * Description must not exceed 150 characters
    * One menu can have one or many categories
2. Owner updated menu item records
3. Owner sees all menu items
4. Owner deletes menu items
5. Owner adds orders from customers with the following terms:
    * Every order, the owner saves a valid email from the customer
    * One customer can order more than one food menu in one order.
    * For each food menu, customers can order more than one serving.
    * If there is a price change in the menu item data, the price on the order that has occurred is not affected
    * Owner sees total price from each order
6. Owner can update orders from customers or change order status
7. The system can automatically change the order status to CANCELED if the order has not been paid until 5 pm
8. Owners can view daily reports and can filter them according to:
    * Specific customer email
    * Total price
    * Date range