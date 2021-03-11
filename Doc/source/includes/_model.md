# Model

## Feed

A Feed is a post that contains users' stories. Please note a Feed is different than a Career, it does not contain any job informations.

### Attributes

Name | Data Type | Description | Platform
--------- | ------- | ----------- | -------
objectId | String | Unique identifier of a Feed object | All
user | User | The user who posted the Feed | All
text | String | The Feed body | All
images | [File] | An array of images in File format. (can be empty) | All
numberOfLikes | Number | How many likes the Feed has recieved | All
numberOfComments | Number | How many comments the Feed has revieved | All
numberOfShares | Number | How many users have shared the Feed | All
numberOfImages | Number | How many images the Feed has | All
parseObject | PFObject(optional) | A reference to the original ParseObject retrieved from server | iOS
isLikedByCurrentUser | Boolean | Whether the current user has liked the Feed or not | iOS

### Fetch All Feeds

Retrieves all Feed object in database. (Newest first)

- Callback: 

Param | Data Type | Description
--------- | ------- | -----------
feeds | [Feed] | Array of Feed objects retrieved. (If fail, value is null)
error | Error | The error message. (If success, value is null)

<aside class="notice">
Note: The `feeds` retrieved will be empty instead of null if there is no Feed to retrieve. A null will be returned only if there is an error occured.
</aside>


```swift
var feedModel = FeedViewModel()

feedModel.fetch { (feeds: [Feed]?, error: Error?) in
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
