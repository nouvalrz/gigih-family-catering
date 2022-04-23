# Final Project Assignment Backend Generasi GIGIH 2.0

Build an API based catering management application using Ruby on Rails This catering management will facilitate the owner to be able to store menus, record orders, and view reports in an easier way.

## Use Case
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

## Instructions

### Prerequisite
1. Install all gem required with ```bundle install```
   or manual install with this list
   ```
    gem "rspec-rails"
    gem "factory_bot_rails"
    gem "faker"
    gem 'rails-controller-testing'
    gem 'jsonapi-serializer', '~> 2.2'
    gem 'jsonapi-rspec', '~> 0.0.11'
    gem 'whenever', require: false
    gem 'whenever-test'
   ```
2. Do database migration ```rails db:migrate```
3. Seed the database with ```rails db:seed```
4. Run the server with ```rails server```
5. If you want do unit testing run this ```rspec -fd```

## Entity Relationship Diagram

<img src="Catering Management ERD.jpg" width=1000>

### My Assumptions
I created the database based on my assumptions about the case study, here it is:
1. The user of this application is only the owner
2. The `order_details.menu_price` in the order record is not referenced to the `menus` table so that it will never be updated with the latest price
3. The `order_details.menu_price` as information for the menu price at that time
4. I use soft delete on the record `menus`, so that when the menu is deleted it doesn't interfere with the existing order record
5. One menu must have 1 category and can be more than 1
6. Customer email is entered directly into the `orders` table and is not created in a separate table, making it easier to add orders with new customers
7. The `order_details.subtotal` is the result of multiplying the menu price and quantity
8. The `orders.total_price` is the result of the subtotal of all order_details records of related orders
9. The order date is considered from when the data was added (refer to `created_at`)

## API Documentation/Specification
API Specification using https://jsonapi.org/ standarization. And also using JSON:API Serializer gem.

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/15761887-db1940df-9252-4726-9180-75071cfd7ef9?action=collection%2Ffork&collection-url=entityId%3D15761887-db1940df-9252-4726-9180-75071cfd7ef9%26entityType%3Dcollection%26workspaceId%3D9dd5c971-fcf2-42e2-8fce-0406681c03a3)

## Auto Cancelation for Order Status
I have created a feature to change the order status to canceled after 5 pm if it has not been paid. I'm using a cronjob set using a gem named `Whenever`.

To see the configuration of the schduled cron job, see the `config\schedule.rb` file and the rake file used is in `lib\tasks\order.rake`.

So for the mechanism, I created a static method on the `Order.set_update_status` whose function will change all order statuses to `CANCELED` on unpaid orders. Then with a cronjob I call the method every 5 pm.

NOTES! cron job will use the time available on the server. So you have to adjust to your own time.

## Reports Filtering
I created a filter feature for the report by email, total price, and time range. To use it, please enter the URL params according to the desired filter.
`customer_email`, `start_price`, `end_price`, `start_date`, `end_date`.
This means that you can dynamically filter with these three parameters.

For more information, please open the API docs on the Postman button above.