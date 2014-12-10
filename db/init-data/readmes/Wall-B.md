# Wall-B

In a world where communication is only allowed over "The Internet"; ONE
PROGRAMMER stands to make a "killr app".

Your mission? Create a website where people can create "Walls" anyone can add
messages on.

## Persistence

Wall-B will introduce you to the behavior and language surrounding the act of
persisting information in a database.  In order to run this application, you
**MUST** have SQLite3 installed on your machine.  Mac OS X users should
automatically have SQLite3 installed, but Windows or Linux users will have to
install it themselves.

Read our [guide for installing SQLite3][sqlite3-install].

## Running the App

1. Fork and clone this repository
1. `bundle install --without production`
1. `cp .env.example .env`
1. `bundle exec rerun -c rackup` # Watches your files and re-starts the app on save.

## Pushing to Production

1. Ensure you've [created a heroku account, installed the heroku toolbelt, and
   logged in to the heroku toolbelt on your machine.][heroku-quickstart]
1. `heroku create`
1. `git push heroku master`
1. `heroku open`

## Functional Requirements

### v[1.0]

  - :heavy_check_mark: A guest may create a wall with a name, description, and author  
  - :heavy_check_mark: A guest may see a list of all walls by name

### v[1.5]

  - [ ] A guest may click on a Wall to see its description
  - [ ] A guest may destroy a wall; but only when they provide the correct author name
  - [ ] A guest may update a wall with a new title, description; but only when they
     provide the correct author name

Not sure how to make this happen? The wiki should
[get you started](https://github.com/codeunion/wall-b/wiki/home)!

### v[2.0]

  - [ ] A guest may "like" a wall
  - [ ] A guest may see the number of likes a wall has had
  - [ ] A guest may add a message to the wall
  - [ ] A guest may "like" a message on the wall

### v[2.5]
  - [ ] A guest may use a shared secret to [encrypt][encryption-and-decryption] a message on a wall.
  - [ ] A guest may use a shared secret to [decrypt][encryption-and-decryption]

## Core Concepts
1. Grouping [data][data] into your own [datatypes][datatypes] that represent
   'human' things.
1. Storing [data][data] submitted by an [http request][request] for later
   retrieval and presentation with a [database][database]
1. Creating [relationships][relational-databases] between [datatypes][datatypes] in
   your database.

[sqlite3-install]:https://github.com/codeunion/fundamentals-of-web-development/wiki/Resources-and-Tools#sqlite
[heroku-quickstart]:https://devcenter.heroku.com/articles/quickstart
[encryption-and-decyption]:https://github.com/codeunion/web-fundamentals/wiki/Glossary#encryption
[data]:https://github.com/codeunion/web-fundamentals/wiki/Glossary#data
[datatypes]:https://github.com/codeunion/web-fundamentals/wiki/Glossary#datatypes
[request]:https://github.com/codeunion/web-fundamentals/wiki/Glossary#request
[relational-databases]:https://github.com/codeunion/web-fundamentals/wiki/Glossary#relational-databases
[database]:https://github.com/codeunion/web-fundamentals/wiki/Glossary#database
