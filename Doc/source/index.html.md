---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - javascript
  - swift
  
toc_footers:
  - <a href='https://github.com/Gellert5225/SwiftyCareer'>Github Repo</a>
  - <a href='http://23.242.50.55:8080/dashboard'>Visit the dashboard</a>

includes:
  - model
  - routes
  - errors
  - others

search: true

code_clipboard: true
---

# Introduction

Welcome to SwiftyCareer documentation, in which you will find the installation guide, model API, cloud function API and REST API.


# Installation

## Prerequisite

You need to have Node.js and MongoDB installed on your machine. 

We use [Parse](http://parseplatform.org) as our backend service, and you can find their documentations [here](http://docs.parseplatform.org).

## Client

We use CocoaPod for iOS client. To start, run `pod install` in the iOS Client directory.

## Database

### Development Database

By default, we use our own MongoDB Community Edition hosted in-house. 

This is the recommended method as you cannot push any database changes to the git repository.

### Local Database

You can also start your own local database to experiment new ideas.

<aside class="notice">
Note: you need to create a database user before you access it.
</aside>

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

- Create a directory to your local database:

`mkdir ~/your/db/path`

- After you have installed MongoDB Community version, run 

`mongod --port 27017 --dbpath your/db/path`

- Then you can either run `mongo` in a shell window to browse the database or download MongoDB Compass. More detail can be found [here](https://docs.mongodb.com/manual/administration/install-community/)

- Then create a database admin to authenticate yourself: (refer to the code on the right)

- Stop the mongo instance and restart with `--auth`:

`mongod --port 27017 --auth --dbpath your/db/path`

- Now authenticate yourself towards the `admin` database:

`use admin`

`db.auth("new_username", "new_password")`

<aside class="warning">
Warning: you need to manually update the development database if you want your local changes to work on the development branch.
</aside>

## Server

Our server is deployed on Heroku, to run the server locally, clone the GitHub repo, and go to the folder "Server/Development". First, you need to install all node dependencies, simply run

`yarn install` 

and then to start the development server, use

`npm run start` 

to start the production server, use

`npm run start-prod`

Donezo! Go visit the webpage at localhost:1337

## Dashboard

We also provide a visual tool for viewing our database. To run the dashboard, startup the server and go to 

`localhost:1337/dashboard`

However you'll need an admin account to log into the database. Open `index.js` in `Server/Development` and add your username and password into the file.

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
