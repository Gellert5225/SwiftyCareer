
# Introduction

Welcome to SwiftyCareer! This repository contains iOS client, server and a database dashboard. 


# Installation

## Prerequisite

You need to have Node.js installed on your machine. 

We use [Parse](http://parseplatform.org) as our backend service, and you can find their documentations [here](http://docs.parseplatform.org).

## Usage

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

## Documentation

The documentation is inside the `Docs/source/index.html.md` file. You can refer to [this](https://github.com/lord/slate/wiki/Markdown-Syntax) article about Markdown syntax.

# Development

## Web

### Front-end

We use EJS as our view engine, you can find more about EJS [here](http://ejs.co). 

All ejs files should be placed insede `views` folder, for javascript, css and images please put them in `public/asset` folder.

### Back-end

We use Node.js and MongoDB as our server + database service. 

All REST routes js files should be placed inside `routes` folder.
