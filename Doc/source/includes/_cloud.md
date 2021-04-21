# Cloud Code

## FetchCommentsForFeed

Fetch the list of comments for a specific feed.

### Request

Param | Type | Description
--------- | ------- | -----------
feedId | String | The object id for Feed.

### Response

Return an array of comments in Parse Object type.

```javascript
Parse.Cloud.run('FetchCommentsForFeed', params).then(
    function(comments) {},
    function (error) {}
);
```

## FetchFeeds

Fetch a list of feeds descending creation date.

### Request

This function does not take any requests.

### Response

Returns an array of Parse Objects and an error message. 

```swift
PFCloud.callFunction(inBackground: "FetchFeeds", 
                    withParameters: nil) { (objects, error) in
    if let err = error {
        // something went wrong
        print(err.localizedDescription)
    } else if let feeds = objects as? [PFObject] {
        // feeds now contain an array of PFObjects, now convert them to Feeds
        // see FeedViewModel.swift for detail implementation.
    }
}
```

```javascript
Parse.Cloud.run("FetchFeeds").then(
    function(feeds) {},
    function(error) {}
);
```

## FetchFeedWithComments

Fetch a feed together with its comments.

### Request

Param | Type | Description
--------- | ------- | -----------
feedId | String | The object id for Feed

### Response

Return a JSON object that contains the feed and its comments.
`{
  feedObject: feed,
  comments: comments
}`

```javascript
const params = { 
    'feedId': req.params.id 
};
Parse.Cloud.run('FetchFeedWithComments', params).then(
    function(feed) {},
    function (error) {}
);
```

## IncrementLikes

Increment the number of likes of a Feed.

### Request

Param | Type | Description
--------- | ------- | -----------
id | String | The object id for Feed
amount | Number | The incrementation amount, 1 or -1

### Response

This function does not return any value.

```swift
PFCloud.callFunction(inBackground: "IncrementLikes",
                    withParameters: ["id": feed.id!, "amount": 1]) { (res, error) in
    if let err = error {
        print(err.localizedDescription)
    }
}
```

```javascript
const params = { 
    'id': req.params.id, 
    'amount': req.body.amount
};
Parse.Cloud.run('IncrementLikes', params).then(
    function(success) {},
    function(error) {}
);
```

## PostComment 

Post a comment under a feed.

### Request

Param | Type | Description
--------- | ------- | -----------
feedId | String | The object id for Feed
commenter | String | The object id for the commenter
commentText | String | The comment itself in text form

### Response

This function does not return any value.

```javascript
const params = { 
    'feedId': req.params.id, 
    'commenter': req.body.commenter, 
    'commentText': req.body.commentText
};
Parse.Cloud.run('PostComment', params).then(
    function(success) {},
    function(error) {}
);
```
