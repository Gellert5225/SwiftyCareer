# Model

## Feed

A Feed is a post that contains users' stories. Please note a Feed is different than a Career, it does not contain any job informations.

### Attributes

Name | Data Type | Description
--------- | ------- | -----------
id | String | Unique identifier of a Feed object, copied from Parse Server.
parseObject | PFObject(optional) | A reference to the original ParseObject retrieved from server.
user | PFUser | The user who posted the Feed
text | String | The Feed body
images | [PFFileObject] | An array of images in PFFile format. (can be empty)
numberOfLikes | Number | How many likes the Feed has recieved.
numberOfComments | Number | How many comments the Feed has revieved.
numberOfShares | Number | How many users have shared the Feed.
numberOfImages | Number | How many images the Feed has.
isLikedByCurrentUser | Boolean | Whether the current user has liked the Feed or not.

### Fetch All Feeds

Retrieves all Feed object in database. (Newest first)

- Callback: 

Param | Data Type | Description
--------- | ------- | -----------
feeds | [Feed] | Array of Feed objects retrieved. (If fail, value is null)
error | Error | The error message. (If success, value is null)

```swift
var feedModel = FeedViewModel()

feedModel.fetchFeeds { (feeds: [Feed]?, error: Error?) in
    if let err = error {
        // something went wrong
        print(err.localizedDescription)
    } else {
        // feeds contains array of Feed objects
    }
}
```

```javascript
```
