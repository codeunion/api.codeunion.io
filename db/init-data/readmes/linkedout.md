# LinkedOut

You already know what a [Content Management System](http://en.wikipedia.org/wiki/Content_management_system) is. In this project we're going to build our own (very small) Content Management System. The content to be managed? Your own résumé.

Think of it like we're going to build a one-person [LinkedIn](https://www.linkedin.com/). That being said, you will be able to build more interesting, multi-user features after you've built an MVP.

If you want to know more about _why_ we are doing this, you can read the [Learning Goals](#learning-goals) section at the end of this document.

## Getting Started

You'll need SQLite3 to complete this project. If you haven't installed it already, read our [guide for installing SQLite3][sqlite3-install].

The source code for this project is available in the [linkedout-example repository][example-project].

To get started, follow these steps:

1. Fork and clone the [linkedout-example repository][example-project]
- Install the dependent gems: `bundle install --without production`
- Create a `.env` file from the default `cp .env.example .env`
- Seed the database with `bundle exec rake db:seed`
- Run the server and restart when files change `bundle exec rerun -c rackup`

## Releases

We've [inherited this project][example-project] and need to add new features. It currently implements the following features:

- User can view a résumé show page
- User can edit user their profile information
- User can add, edit, and delete jobs
- User can add and delete skills

_You can see a history of all releases for this project on the [project's README page][example-project] under the [resources section](https://github.com/codeunion/linkedout-example#releases)._

Now it is up to us to add extra features to this project. **Write code to satisfy the requirements in release 1.5.0 and 1.8.0**.

The _releases after v1.8.0 are for more advanced work_. If you are up for the challenge, go for it!

### v[1.5.0] Display education information

Currently this application allows for résumés that show a person's jobs and skills. It would be nice to see their education history as well.

This is where you come in. Add a `schools` resource to the application.

Requirements:

- [ ] Résumé show page displays a user's education history
- [ ] User can have many schools
- [ ] Schools belong to a user
- [ ] Schools have a name, graduation year, and subjects studied

_Note: you can (and should) look at how `jobs` and `skills` are implemented. Make sure to look at the `models.rb` file and the `db:seed` task in the `Rakefile`. This will help guide you towards an effective solution._

### v[1.8.0] Full asynchronous CRUD for schools

Jobs and skills have asynchronous CRUD actions, so shouldn't schools work that way too?

Whoa, buddy! This is gonna be fun. You're going to get your hands dirty with JavaScript and jQuery.

Lucky for you, there is plenty of commented example code to use as a reference. All the code you will be writing in this release is very similar to the code in `jobs.js`. **Make sure you read, experiment with, and understand the existing JS code.**

Requirements:

- [ ] User can add schools on the résumé show page
- [ ] User can edit schools on the résumé show page
- [ ] User can delete schools on the résumé show page
- [ ] Creating, editing, and deleting schools occurs asynchronously
- [ ] Added schools show on the page in the appropriate spot without refresh
- [ ] Edited schools are updated on the page without refresh
- [ ] Deleted schools are removed from the page without refresh

You're going to bump into lots of new material as you solve this release. In particular, you're going to want to keep these reference materials handy:

- [jQuery's .post() method][jquery-api-post]
- [jQuery's .ajax() method][jquery-api-ajax]
- [key concepts for AJAX][jquery-learn-ajax]

### v[1.9.0] Improve the UI

- [ ] Page has pretty colors and fonts
- [ ] Design follows [fundamentals of User Interface design](http://blog.teamtreehouse.com/10-user-interface-design-fundamentals)

### v[2.0.0] Filter by skill

- [ ] User can search for other users by a specific skill
- [ ] Clicking on a skill links to a page listing all users with that skill at a URL like `/skills/web-development`

## Learning Goals

The purpose of this project is develop a richer understanding of how web applications can manipulate data using asynchronous requests. Through the process of building a site that allows users to read data from and write data to a server, we will learn about synchronous vs. asynchronous requests and use JavaScript to improve the UX (User Experience) of a site through improved client-side behavior.

By the end of the project, we will:

- Be able to use jQuery to send asynchronous requests, listen for a response, and update the DOM
- Be able to use request data to create new records in a database
- Understand how JavaScript can be used to manipulate the DOM

[example-project]:https://github.com/codeunion/linkedout-example
[sqlite3-install]:https://github.com/codeunion/fundamentals-of-web-development/wiki/Resources-and-Tools#sqlite
[jquery-api-post]:http://api.jquery.com/jquery.post/
[jquery-api-ajax]:http://api.jquery.com/jQuery.ajax/
[jquery-learn-ajax]:http://learn.jquery.com/ajax/key-concepts/
