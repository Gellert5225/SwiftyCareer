
# Introduction

Welcome to SwiftyCareer! This repository contains iOS client, server and a database dashboard. 


# Installation

## Prerequisite

You need to have Node.js and MongoDB installed on your machine. 

We use [Parse](http://parseplatform.org) as our backend service, and you can find their documentations [here](http://docs.parseplatform.org).

## Install

### Client

We use CocoaPod for iOS client. To start, run `pod install` in the iOS Client directory.

### Database

> Note: you need to create a database user before you access it.

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

> Note: the database in localhost only exists on the development machine and cannot be shared with other developers working on a different network. 

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

## Documentation

The documentation is inside the `Doc/source/index.html.md` file. 

To contribute to the documentation, edit the `*.md` file inside the `source`  and `source/includes` folder.

> To build the doc, plese see [this](https://github.com/slatedocs/slate/wiki/Using-Slate-Natively) page.
> You can refer to [this](https://github.com/lord/slate/wiki/Markdown-Syntax) article about Markdown syntax.

