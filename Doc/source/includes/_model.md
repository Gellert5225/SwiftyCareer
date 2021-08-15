# Model

Data models and functions.

<aside class="notice">
Note: This document represents the database model as well as on iOS platform.
</aside>

## SCObject (iOS)

Native representation of a generic object.

### Attributes
Name | Data Type | Description
--------- | ------- | -----------
_id | String | Unique identifier of an object

## Feed (Database)

<aside class="notice">
Note: On iOS, this is alsl a sub-class of SCObject.
</aside>

A Feed is a post that contains users' stories. Please note a Feed is different than a Career, it does not contain any job informations.

### Attributes

Name           | Data Type | Description
-------------- | --------- | -----------
_id            | String    | Unique identifier of a Feed object 
author         | User      | The user who posted the Feed 
text           | String    | The Feed body
text_JSON      | String    | The Feed body in JSON format 
images         | [String]? | An array of image URLs 
like_count     | Number    | How many likes the Feed has recieved 
comment_count  | Number    | How many comments the Feed has revieved 
share_count    | Number    | How many users have shared the Feed 
liked_user_ids | [String]? | Whether the current user has liked the Feed or not 

## User (Database)

<aside class="notice">
Note: On iOS, this is alsl a sub-class of SCObject.
</aside>

A User contains login and access control information.

### Attributes

Name            | Data Type | Description
--------------- | --------- | -----------
_id             | String    | Unique identifier of a Feed object 
username        | String    | Username to sign in
diaplay_name    | String    | Full name to be displayed, default is username 
email           | String    | Email of the user
hashed_password | String    | Hashed password using bcrypt 
roles           | [Role]?   | An array of user role for access control/authorization
profile_picture | String    | URL of user's profile picture
bio             | String    | Bio of the user 
position        | String    | Current job position of user

## Role (Database)

A Role is used to manage a user's access control. It currently has 3 values: `user`, `admin` and `mod`.

### Attributes

Name | Data Type | Description
---- | --------- | -----------
_id  | String    | Unique identifier of a Feed object 
name | String    | Name of the role
