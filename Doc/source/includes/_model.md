# Model

Data models and functions.

<aside class="notice">
Note: Attributes marked as 'All' in Platform are also entries in database.
</aside>

## SCObject

Native representation of a generic object.

### Attributes
Name | Data Type | Description | Platform
--------- | ------- | ----------- | -------
objectId | String | Unique identifier of an object | All
parseObjeect | PFObject? | A reference to the original ParseObject retrieved from server | iOS

## Feed

Sub-class of [`SCObject`](#scobject).

A Feed is a post that contains users' stories. Please note a Feed is different than a Career, it does not contain any job informations.

### Attributes

Name | Data Type | Description | Platform
--------- | ------- | ----------- | -------
objectId | String | Unique identifier of a Feed object | All
user | User | The user who posted the Feed | All
text | String | The Feed body | All
text_JSON| String | The Feed body in JSON format | All
images | [File] | An array of images in File format. (can be empty) | All
numberOfLikes | Number | How many likes the Feed has recieved | All
numberOfComments | Number | How many comments the Feed has revieved | All
numberOfShares | Number | How many users have shared the Feed | All
numberOfImages | Number | How many images the Feed has | All
parseObject | PFObject? | A reference to the original ParseObject retrieved from server | iOS
isLikedByCurrentUser | Boolean | Whether the current user has liked the Feed or not | iOS

## SCViewModel

An intermediate class binding the data and the view.

<aside class="warning">
Warning: This is a virtual/abstract class, you should not create an instance of this class directly.
</aside>

### Attributes
Name | Data Type | Description | Platform
--------- | ------- | ----------- | -------
objects | [SCObject] | Array of objects need to be displayed. | iOS
isLoading | Boolean | Whether the view model is doing background work. Default: `true` | iOS

### Functions

- `func fetch(onCompletion complete: @escaping ([SCObject]?, Error?) -> Void)`

Fetching the objects that need to be displayed.

## FeedViewModel

Sub-class of [`SCViewModel`](#scviewmodel).

Fetching and processing feeds.

<aside class="notice">
Note: Only available on iOS
</aside>

### Functions

- `override func fetch(onCompletion complete: @escaping ([SCObject]?, Error?) -> Void)`

Retrieves all Feed object in database. (Newest first)

Param | Data Type | Description
--------- | ------- | -----------
complete | callback | Returns an array of Feed objects and an Error.

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
