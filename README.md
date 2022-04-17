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

## API Documentation/Specification
API Specification using https://jsonapi.org/ standarization.

### Create Category
Request :
- Method : POST
- Endpoint : /api/v1/categories
- Header : 
    - Content-Type: application/json
    - Accept: application/json
- Body :
```json
{
    "name" : "string" 
}
```

Response :
```json
{
    "links": {
        "self": "string"
    },
    "data": {
        "type": "string",
        "id": "integer, unique",
        "attributes": {
            "name": "string",
            "createdAt" : "datetime",
            "updatedAt" : "datetime"
        }
    }
}

```

### List Category
Request :
- Method : GET
- Endpoint : /api/v1/categories
- Header : 
    - Accept: application/json

Response :
```json
{
    "links": {
        "self": "string"
    },
    "data": [
        {
            "type": "string",
            "id": "integer, unique",
            "attributes": {
                "name": "string",
                "createdAt" : "datetime",
                "updatedAt" : "datetime"
            },
            "links": {
                "self": "string"
            }
        },
        {
            "type": "string",
            "id": "integer, unique",
            "attributes": {
                "name": "string",
                "createdAt" : "datetime",
                "updatedAt" : "datetime"
            },
            "links": {
                "self": "string"
            }
        },
    ]
}
```

### Get Category
Request :
- Method : GET
- Endpoint : /api/v1/categories/{id_category}
- Header : 
    - Accept: application/json

Response :
```json
{
    "links": {
        "self": "string"
    },
    "data": {
        "type": "string",
        "id": "integer, unique",
        "attributes": {
            "name": "string",
            "createdAt" : "datetime",
            "updatedAt" : "datetime"
        }
    }
}

```

### Update Category
Request :
- Method : PUT
- Endpoint : /api/v1/categories/{id_category}
- Header : 
    - Content-Type: application/json
    - Accept: application/json
- Body :
```json
{
    "name" : "string" 
}
```

Response :
```json
{
    "links": {
        "self": "string"
    },
    "data": {
        "type": "string",
        "id": "integer, unique",
        "attributes": {
            "name": "string",
            "createdAt" : "datetime",
            "updatedAt" : "datetime"
        }
    }
}

```

### Delete Category
Request :
- Method : DELETE
- Endpoint : /api/v1/categories/{id_category}
- Header : 
    - Accept: application/json

Response :
`The server responds with only top-level meta data`

### Create Menu Item
Request :
- Method : POST
- Endpoint : /api/v1/menu-items
- Header : 
    - Content-Type: application/json
    - Accept: application/json
- Body :
```json
{
    "name" : "string, unique",
    "description": "string, maxLength: 150",
    "price": "long, minValue: 0.01",
    "categories": [
        {"id": "integer"},
        {"id": "integer"}
    ]
}
```

Response :
```json
{
    "links": {
        "self": "string"
    },
    "data": {
        "type": "string",
        "id": "integer, unique",
        "attributes": {
            "name": "string",
            "description": "string",
            "price": "long",
            "createdAt" : "datetime",
            "updatedAt" : "datetime"
        },
        "relationships": {
            "menu_categories": {
                "links": {
                    "self": "string",
                    "related": "string"
                },
                "data": [
                    {
                        "type": "string",
                        "id": "integer",
                        "attributes": {
                            "name": "string"
                        }
                    },
                    {
                        "type": "string",
                        "id": "integer",
                        "attributes": {
                            "name": "string"
                        }
                    }
                ]
            }
        }
    }
}

```

### List Menu Items
Request :
- Method : GET
- Endpoint : /api/v1/menu-items
- Header : 
    - Accept: application/json

Response :
```json
{
    "links": {
        "self": "string"
    },
    "data": [
        {
            "type": "string",
            "id": "integer, unique",
            "attributes": {
                "name": "string",
                "description": "string",
                "price": "long",
                "createdAt" : "datetime",
                "updatedAt" : "datetime"
            },  
            "links": {
                "self": "string"
            },
            "relationships": {
                "menu_categories": {
                    "links": {
                        "self": "string",
                        "related": "string"
                    },
                    "data": [
                        {
                            "type": "string",
                            "id": "integer",
                            "attributes": {
                                "name": "string"
                            }
                        },
                        {
                            "type": "string",
                            "id": "integer",
                            "attributes": {
                                "name": "string"
                            }
                        }
                    ]
                }
            }
        },
        {
            "type": "string",
            "id": "integer, unique",
            "attributes": {
                "name": "string",
                "description": "string",
                "price": "long",
                "createdAt" : "datetime",
                "updatedAt" : "datetime"
            }, 
            "links": {
                "self": "string"
            },
            "relationships": {
                "menu_categories":{
                    "links": {
                        "self": "string",
                        "related": "string"
                    },
                    "data": [
                        {
                            "type": "string",
                            "id": "integer",
                            "attributes": {
                                "name": "string"
                            }
                        },
                        {
                            "type": "string",
                            "id": "integer",
                            "attributes": {
                                "name": "string"
                            }
                        }
                    ]
                }
            }
        },
    ]
}
```

### Get Menu Item
Request :
- Method : GET
- Endpoint : /api/v1/menu-items/{id_menu_item}
- Header : 
    - Accept: application/json

Response :
```json
{
    "links": {
        "self": "string"
    },
    "data": [
        {
            "type": "string",
            "id": "integer, unique",
            "attributes": {
                "name": "string",
                "description": "string",
                "price": "long",
                "createdAt" : "datetime",
                "updatedAt" : "datetime"
            },
            "relationships": {
                "menu_categories": {
                    "links": {
                        "self": "string",
                        "related": "string"
                    },
                    "data": [
                        {
                            "type": "string",
                            "id": "integer",
                            "attributes": {
                                "name": "string"
                            }
                        },
                        {
                            "type": "string",
                            "id": "integer",
                            "attributes": {
                                "name": "string"
                            }
                        }
                    ]
                }
            }
        }
    ]
}
```

### Update Menu Item
Request :
- Method : PUT
- Endpoint : /api/v1/menu-items/{id_menu_item}
- Header : 
    - Content-Type: application/json
    - Accept: application/json
- Body :
```json
{
    "name" : "string, unique",
    "description": "string, maxLength: 150",
    "price": "long, minValue: 0.01",
    "categories": [
        {"id": "integer"},
        {"id": "integer"}
    ]
}
```

Response :
```json
{
    "links": {
        "self": "string"
    },
    "data": [
        {
            "type": "string",
            "id": "integer, unique",
            "attributes": {
                "name": "string",
                "description": "string",
                "price": "long",
                "createdAt" : "datetime",
                "updatedAt" : "datetime"
            },
            "relationships": {
                "menu_categories": {
                    "links": {
                        "self": "string",
                        "related": "string"
                    },
                    "data": [
                        {
                            "type": "string",
                            "id": "integer",
                            "attributes": {
                                "name": "string"
                            }
                        },
                        {
                            "type": "string",
                            "id": "integer",
                            "attributes": {
                                "name": "string"
                            }
                        }
                    ]
                }
            }
        }
    ]
}
```

### Delete Menu Item
Request :
- Method : DELETE
- Endpoint : /api/v1/menu-items/{id_menu_items}
- Header : 
    - Accept: application/json

Response :
`The server responds with only top-level meta data`

### Create Order
Request :
- Method : POST
- Endpoint : /api/v1/orders
- Header : 
    - Content-Type: application/json
    - Accept: application/json
- Body :
```json
{
    "name" : "string, unique",
    "description": "string, maxLength: 150",
    "price": "long, minValue: 0.01",
    "categories": [
        {"id": "integer"},
        {"id": "integer"}
    ],
    "orderDate": "date",
    "customerEmail": "string",
    "orderItems": [
        {
            "itemId": "integer",
            "quantity": "integer"
        },
        {
            "itemId": "integer",
            "quantity": "integer"
        },
    ]
}
```

Response :
```json
{
    "links": {
        "self": "string"
    },
    "data": {
        "type": "string",
        "id": "integer, unique",
        "attributes": {
            "orderDate": "date",
            "customerEmail": "string",
            "totalPrice": "long",
            "status": "string",
            "createdAt" : "datetime",
            "updatedAt" : "datetime"
        },
        "relationships": {
            "order_details": {
                "links": {
                    "self": "string",
                    "related": "string"
                },
                "data": [
                    {
                        "type": "string",
                        "id": "integer",
                        "attributes": {
                            "price": "long",
                            "quantity": "integer",
                            "subtotal": "long",
                        }
                    },
                    {
                        "type": "string",
                        "id": "integer",
                        "attributes": {
                            "price": "long",
                            "quantity": "integer",
                            "subtotal": "long",
                        }
                    }
                ]
            }
        }
    }
}
```

### List Orders
Request :
- Method : GET
- Endpoint : /api/v1/orders
- Header : 
    - Accept: application/json

Response :
```json
{
    "links": {
        "self": "string"
    },
    "data": [
        {
            "type": "string",
            "id": "integer, unique",
            "attributes": {
                "orderDate": "date",
                "customerEmail": "string",
                "totalPrice": "long",
                "status": "string",
                "createdAt" : "datetime",
                "updatedAt" : "datetime"
            },
            "links": {
                "self": "string"
            },
            "relationships": {
                "order_details": {
                    "links": {
                        "self": "string",
                        "related": "string"
                    },
                    "data": [
                        {
                            "type": "string",
                            "id": "integer",
                            "attributes": {
                                "price": "long",
                                "quantity": "integer",
                                "subtotal": "long",
                            }
                        },
                        {
                            "type": "string",
                            "id": "integer",
                            "attributes": {
                                "price": "long",
                                "quantity": "integer",
                                "subtotal": "long",
                            }
                        }
                    ]
                }
            }
        },
        {
            "type": "string",
            "id": "integer, unique",
            "attributes": {
                "orderDate": "date",
                "customerEmail": "string",
                "totalPrice": "long",
                "status": "string",
                "createdAt" : "datetime",
                "updatedAt" : "datetime"
            },
            "links": {
                "self": "string"
            },
            "relationships": {
                "order_details": {
                    "links": {
                        "self": "string",
                        "related": "string"
                    },
                    "data": [
                        {
                            "type": "string",
                            "id": "integer",
                            "attributes": {
                                "price": "long",
                                "quantity": "integer",
                                "subtotal": "long",
                            }
                        },
                        {
                            "type": "string",
                            "id": "integer",
                            "attributes": {
                                "price": "long",
                                "quantity": "integer",
                                "subtotal": "long",
                            }
                        }
                    ]
                }
            }
        }
    ]
}
```

### Get Order
Request :
- Method : GET
- Endpoint : /api/v1/orders/{id_orders}
- Header : 
    - Accept: application/json

Response :
```json
{
    "links": {
        "self": "string"
    },
    "data": {
        "type": "string",
        "id": "integer, unique",
        "attributes": {
            "orderDate": "date",
            "customerEmail": "string",
            "totalPrice": "long",
            "status": "string",
            "createdAt" : "datetime",
            "updatedAt" : "datetime"
        },
        "relationships": {
            "order_details": {
                "links": {
                    "self": "string",
                    "related": "string"
                },
                "data": [
                    {
                        "type": "string",
                        "id": "integer",
                        "attributes": {
                            "price": "long",
                            "quantity": "integer",
                            "subtotal": "long",
                        }
                    },
                    {
                        "type": "string",
                        "id": "integer",
                        "attributes": {
                            "price": "long",
                            "quantity": "integer",
                            "subtotal": "long",
                        }
                    }
                ]
            }
        }
    }
}
```

### Update Orders
Request :
- Method : PUT
- Endpoint : /api/v1/menu-items/{id_menu_item}
- Header : 
    - Content-Type: application/json
    - Accept: application/json
- Body :
```json
{
    "name" : "string, unique",
    "description": "string, maxLength: 150",
    "price": "long, minValue: 0.01",
    "categories": [
        {"id": "integer"},
        {"id": "integer"}
    ],
    "orderDate": "date",
    "customerEmail": "string",
    "orderItems": [
        {
            "itemId": "integer",
            "quantity": "integer"
        },
        {
            "itemId": "integer",
            "quantity": "integer"
        },
    ]
}
```

Response :
```json
{
    "links": {
        "self": "string"
    },
    "data": {
        "type": "string",
        "id": "integer, unique",
        "attributes": {
            "orderDate": "date",
            "customerEmail": "string",
            "totalPrice": "long",
            "status": "string",
            "createdAt" : "datetime",
            "updatedAt" : "datetime"
        },
        "relationships": {
            "order_details": {
                "links": {
                    "self": "string",
                    "related": "string"
                },
                "data": [
                    {
                        "type": "string",
                        "id": "integer",
                        "attributes": {
                            "price": "long",
                            "quantity": "integer",
                            "subtotal": "long",
                        }
                    },
                    {
                        "type": "string",
                        "id": "integer",
                        "attributes": {
                            "price": "long",
                            "quantity": "integer",
                            "subtotal": "long",
                        }
                    }
                ]
            }
        }
    }
}
```

### Delete Order
Request :
- Method : DELETE
- Endpoint : /api/v1/orders/{id_order}
- Header : 
    - Accept: application/json

Response :
`The server responds with only top-level meta data`