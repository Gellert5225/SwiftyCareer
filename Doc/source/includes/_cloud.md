# Cloud Code

## FetchFeeds

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
```

## IncrementLikes

Increment the number of likes of a Feed

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
