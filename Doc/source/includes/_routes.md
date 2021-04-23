# REST Routes

## Authentication

Authenticate a user.

Route     |   XHR   |     Description     |  req.params |          req.body           | req.query
----------|---------|---------------------|-------------|-----------------------------|-----------
/register |  `POST` | Register a new user |     N/A     | {username, password, email} |    N/A    
/login    |  `POST` | Log in a user       |     N/A     |    {username, password}     |    N/A
/logout   |  `POST` | Logout a user       |     N/A     |             N/A             |    N/A

## Get All Feeds

Get all feeds (newest first)

```javascript
$.ajax({
    type: 'get',
    url: '/feeds',
    dataType: 'json'
})
.done(function(result) {
    if (result.error) {
        console.log('ERROR! ' + result.error.code + ' ' + result.error.message);
    } else {
        console.log(result.feeds);
    }
})
.fail(function(jqXHR, textStatus, errorThrown) {
    console.log(jqXHR);
    console.log(textStatus);
    console.log(errorThrown);
})
```

### HTTP Request

`GET /feeds`

### HTTP Response
Field     | Data Type | Description
----------|-----------|------------
feeds     |  [Feed]?  | Array of Feed objects retrieved. (If fail, value is null)
error     |  Error?   | The error message. (If success, value is null)

## Get Comments For A Feed

Get all comments under a Feed.

```javascript
$.ajax({
    type: 'get',
    url: '/feeds/:id/comments', // replace :id with the actual objectId of the Feed
    dataType: 'json'
})
.done(function(result) {
    if (result.error) {
        console.log('ERROR! ' + result.error.code + ' ' + result.error.message);
    } else {
        console.log(result.comments);
    }
})
.fail(function(jqXHR, textStatus, errorThrown) {
    console.log(jqXHR);
    console.log(textStatus);
    console.log(errorThrown);
})
```

### HTTP Request

`GET /feeds/:id/comments`

### HTTP Response
Field     | Data Type | Description
----------|-----------|------------
comments  | [Comment]?| Array of Comment objects retrieved. (If fail, value is null)
error     |  Error?   | The error message. (If success, value is null)
