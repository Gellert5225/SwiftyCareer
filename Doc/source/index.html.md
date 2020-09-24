---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - swift
  - javascript

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>

includes:
  - errors

search: true

code_clipboard: true
---

# Introduction

Welcome to SwiftyCareer documentation, in which you will find the installation guide, model API, cloud function API and REST API.


# Installation

## Prerequisite

You need to have Node.js and MongoDB installed on your machine. 

We use [Parse](http://parseplatform.org) as our backend service, and you can find their documentations [here](http://docs.parseplatform.org).

## Install

### Client

We use CocoaPod for iOS client. To start, run `pod install` in the iOS Client directory.

### Database

<aside class="notice">
Note: you need to create a database user before you access it.
</aside>

- Create a directory to your local database:

`mkdir ~/your/db/path`

- After you have installed MongoDB Community version, run 

`mongod --port 27017 --dbpath your/db/path`

- Then you can either run `mongo` in a shell window to browse the database or download MongoDB Compass. More detail can be found [here](https://docs.mongodb.com/manual/administration/install-community/)

- Then create a database admin to authenticate yourself: (refer to the code on the right)

> To create a database user, in your Mongo shell, enter: 

```shell
db.createUser({
    user: 'new_username',
    pwd: 'new_password',
    roles: [
        { role: 'userAdminAnyDatabase', db: 'admin' }
    ]
})
```

- Stop the mongo instance and restart with `--auth`:

`mongod --port 27017 --auth --dbpath your/db/path`

- Now authenticate yourself towards the `admin` database:

`use admin`

`db.auth("myDbOwner", "abc123")`

### Server

Our server is deployed on Heroku, to run the server locally, clone the GitHub repo, and go to the folder "Server/Development". First, you need to install all node dependencies, simply run

`npm install` 

and then to start the development server, use

`npm start` 

to start the production server, use

`npm start-prod`

Donezo! Go visit the webpage at localhost:1337

## Dashboard

We also provide a visual tool for viewing our database. To run the dashboard, startup the server and go to 

`localhost:1337/dashboard`

However you'll need an admin account to log into the database. Contact me if you need one.

<aside class="notice">
Note: the database in localhost only exists on the development machine and cannot be shared with other developers working on a different network. 
</aside>

# Development

## Mobile

### iOS

Currently only support iPhone. iPad version will be implemented in the future. 

SwiftUI is fairly new and buggy so we decide to use UIKit and Swift in our client code.

## Web

### Front-end

We use EJS as our view engine, you can find more about EJS [here](http://ejs.co). 

All ejs files should be placed insede `views` folder, for javascript, css and images please put them in `public/asset` folder.

### Back-end

We use Node.js and MongoDB as our server + database service. 

All REST routes js files should be placed inside `routes` folder.


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

# Cloud Code

## FetchFeeds

### Request

This function does not take any requests.

### Return

Returns an array of Parse Objects and an error message. 

```swift
PFCloud.callFunction(inBackground: "FetchFeeds", withParameters: nil) { (objects, error) in
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
