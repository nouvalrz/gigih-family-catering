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

## API Documentaion/Specification
API Specification using https://jsonapi.org/ standarization.

### Create Category
Request :
    * Method : POST
    * Endpoint : /api/v1/categories
    * Header : 
        * Content-Type: application/json
        * Accept: application/json
    * Body :
```
{
    "name" : "string" 
}
```

Response :
```
{
    "links": {
        "self": "string"
    },
    "data": {
        "type": "string",
        "id": "integer, unique",
        "attributes": {
            "name": "string"
        }
    }
}

```

### List Category
Request :
    * Method : GET
    * Endpoint : /api/v1/categories
    * Header : 
        * Accept: application/json

Response :
```
{
    "links": {
        "self": "string"
    },
    "data": [
        {
            "type": "string",
            "id": "integer, unique",
            "attributes": {
                "name": "string"
            }
        },
        {
            "type": "string",
            "id": "integer, unique",
            "attributes": {
                "name": "string"
            }
        },
    ]
}
```

### Get Category
Request :
    * Method : GET
    * Endpoint : /api/v1/categories/{id_category}
    * Header : 
        * Accept: application/json

Response :
```
{
    "links": {
        "self": "string"
    },
    "data": {
        "type": "string",
        "id": "integer, unique",
        "attributes": {
            "name": "string"
        }
    }
}

```

### Update Category
Request :
    * Method : PUT
    * Endpoint : /api/v1/categories/{id_category}
    * Header : 
        * Content-Type: application/json
        * Accept: application/json
    * Body :
```
{
    "name" : "string" 
}
```

Response :
```
{
    "links": {
        "self": "string"
    },
    "data": {
        "type": "string",
        "id": "integer, unique",
        "attributes": {
            "name": "string"
        }
    }
}

```

### Delete Category
Request :
    * Method : DELETE
    * Endpoint : /api/v1/categories/{id_category}
    * Header : 
        * Accept: application/json

Response :
`The server responds with only top-level meta data`



