## Open Todo API: External API With Authentication

* API for a to-do list application, so that users can authenticate and manage their to-do list externally.
* Users can change the same data from the command line.
* It supports other platforms and programmers can build on the Open API in new and exciting ways.


### How it works
Manage to-do list using cURL.

* Type example code in command line.
* cURL is a popular command-line tool for interacting with HTTP.
* User's password is NOT returned for security purpose.
* User can ONLY manipulate his/her own to-dos, not other's.
* All responses are in JSON form. See [example](#returned-data-in-json).

[How to create](#create) | [View to-do](#view) | [Edit to-do](#edit)  | [Delete to-do](#delete) | [Returned Data](#returned-data-in-json)


#### Create
1. Sign up with your username, email and password.
```bash
$ curl -u test@test.io:testtest -d "user[username]=John Doe" -d "user[email]=your_email@address.com" -d "user[password]=yourPassword" https://open-api-ghbooth12.herokuapp.com/api/users
```
2. Create a to-do list.
```bash
$ curl -u your_email@address.com:yourPassword -d "list[title]=Things to do today" https://open-api-ghbooth12.herokuapp.com/api/users/your-id-number/lists
```
 _Default to private to-do list. To make it public, add "list[private]=false"_
```bash
$ curl -u your_email@address.com:yourPassword -d "list[title]=Things to do today" -d "list[private]=false" https://open-api-ghbooth12.herokuapp.com/api/users/your-id-number/lists
```
3. Create a to-do item
```bash
$ curl -u your_email@address.com:yourPassword -d "item[description]=Grocery shopping" https://open-api-ghbooth12.herokuapp.com/api/lists/list-id-number/items
```

#### View
* View my lists
```bash
$ curl -u your_email@address.com:yourPassword https://open-api-ghbooth12.herokuapp.com/api/users/your-id-number/lists
```

* View items of selected list
```bash
$ curl -u your_email@address.com:yourPassword https://open-api-ghbooth12.herokuapp.com/api/lists/list-id-number/items
```

#### Edit
* Edit my user account
```bash
$ curl -X PUT -u your_email@address.com:yourPassword -d "user[username]=Mark Doe" https://open-api-ghbooth12.herokuapp.com/api/users/your-id-number
```

* Edit my list title
```bash
$ curl -X PUT -u your_email@address.com:yourPassword -d "list[title]=Todo tomorrow" https://open-api-ghbooth12.herokuapp.com/api/users/your-id-number/lists/list-id-number
```

* Edit my item description
```bash
$ curl -X PUT -u your_email@address.com:yourPassword -d "item[description]=Walk dog" https://open-api-ghbooth12.herokuapp.com/api/lists/list-id-number/items/item-id-number
```
_Mark to-do item complete_
```bash
$ <span class="warning">curl -X PUT</span> -u <span class="danger">your_email@address.com:yourPassword</span> -d <span class="info">"item[completed]=true"</span> https://open-api-ghbooth12.herokuapp.com/api/lists/<b>list-id-number</b>/items/<b>item-id-number</b>
```

#### Delete
* Delete my user account
_Once you delete your account, all your list/item will be deleted too._
```bash
$ curl -u your_email@address.com:yourPassword -X DELETE htps://open-api-ghbooth12.herokuapp.com/api/users/your-id-number
```

* Delete my list
```bash
$ curl -u your_email@address.com:yourPassword -X DELETE https://open-api-ghbooth12.herokuapp.com/api/users/your-id-number/lists/list-id-number
```

* Delete my item
```bash
$ curl -u your_email@address.com:yourPassword -X DELETE https://open-api-ghbooth12.herokuapp.com/api/lists/list-id-number/items/item-id-number
```

#### Returned Data in JSON
* Example data returned
```bash
{
  "lists": [
    {
      "id": 1,
      "creator": "John Smith",
      "title": "ToDo today",
      "items": [
        {
          "id": 8,
          "description": "Read book",
          "completed": false
        },
        {
          "id": 9,
          "description": "Cook",
          "completed": false
        }
      ],
      "status": "Private List",
      "created_at": "May 10, 2016"
    },
    {
      "id": 3,
      "creator": "John Smith",
      "title": "Things to do tomorrow",
      "items": [
        {
          "id": 2,
          "description": "Relax",
          "completed": false
        },
        {
          "id": 3,
          "description": "study",
          "completed": true
        }
      ],
      "status": "Public List",
      "created_at": "May 10, 2016"
    }
  ]
}
```