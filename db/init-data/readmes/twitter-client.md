# Twitter Client

For a detailed overview and instructions, [visit the the project wiki](https://github.com/codeunion/twitter-client/wiki).

To get started, you'll need to:

1. Fork this repository to your own GitHub account
2. Open a Terminal and clone this repository to your local computer
2. Navigate to the repository on your local computer
3. Open the repository in Sublime Text


## Your Mission

Your mission is to build a command line ruby program that allows a user to
perform the following tasks:

1. See any users timeline -- `./twitter timeline zspencer`
1. See any users information (Join date, location, etc.) -- `./twitter info jfarmer`
1. See any users followers -- `./twitter followers <yourhandle>`
1. See who is following any user -- `./twitter following <yourhandle>`
1. Send a tweet -- `./twitter tweet I know kung fu`
1. Send a DM -- `./twitter message zspencer do you know kung fu?`
1. Follow a user -- `./twitter follow jfarmer`
1. Unfollow a user -- `./twitter unfollow zspencer`

## Getting Started

We've provided a very tiny skeleton of a command line application

1. Fork this repository and Clone to your machine
1. CD into this directory
1. Run `bundle install`
1. [Register your application with
   Twitter](docs/twitter.md#registering-your-application)
1. run `./twitter`

## Helpful Resources

1. [How The Internet Works](docs/internet.md)
1. [Working with Twitter](docs/twitter.md)
1. [Glossary of Terms](docs/glossary.md)

## Bored?

Did you rush through this without breaking a sweat? Here's some additional
challenges:

* Publish this as a gem! - Perhaps load the users credentials from a file in
  their home directory
* Make a Text Messaging app off the [Twilio API](http://www.twilio.com/)
* ???
