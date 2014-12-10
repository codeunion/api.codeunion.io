# LinkedOut

A one-person [LinkedIn](https://www.linkedin.com/). That being said, you will be able to build more interesting, multi-user features after you've built an MVP.

## Getting Started

You'll need SQLite3 to complete this project. If you haven't installed it already, read our [guide for installing SQLite3][sqlite3-install].

Once you have SQLite3 working, you can set up your development environment with the following steps:

1. Fork, clone and run this repository
- Install the dependent gems: `bundle install --without production`
- Create a `.env` file from the default `cp .env.example .env`
- Seed the database with `bundle exec rake db:seed`
- Run the server and restart when files change `bundle exec rerun -c rackup`

### Files In This Repository

```sh
├── .env.example # a sample .env file for setting environment variables
├── .gitignore # list of files to be ignored by git
├── CODE_OF_CONDUCT.md # standards of relating between contributors
├── CONTRIBUTING.md # how to contribute
├── Gemfile # list of gems that this project uses
├── Gemfile.lock # a "locked" version of the Gemfile, which includes version numbers for all the gems
├── LICENSE.md # license for project material
├── README.md # you are here. ;D
├── Rakefile # a place to store one-off commands (like seeding the database)
├── config # put configuration scripts in this folder
│   └── dotenv.rb # like this one! for the dotenv gem
├── config.ru # this tells our web server how to run
├── linkedout.rb # the most important file! this is the heart of our Sinatra web app, where we define how to respond to requests from across the web
├── models.rb # where we define the data models for the app, using an ORM like DataMapper
├── public # a folder to hold "static assets" like CSS files, images, and JavaScript files
│   ├── css # folder to hold CSS files
│   │   ├── main.css # our custom CSS
│   │   └── normalize.css # a commonly used CSS library to aid in cross-browser compatibility
│   └── js # folder to hold JavaScript script files
│       └── jobs.js # script to manage behavior relating to job resources
│       └── skills.js # script to manage behavior relating to skills resources
└── views # a folder to hold the HTML templates for our pages
    ├── layout.erb # this is the main template for our site
    ├── partials # a folder containing a bunch of partials (not listed, because there are a bunch of them)
    └── resumes # a sub-folder, to hold specific templates related to résumés
        └── show.erb # the template for the résumé show page
    └── users # a sub-folder, to hold specific templates related to users
        └── edit.erb # the template for the user edit page
```

## Releases

_Note: there are other, smaller [releases][gh-help-releases] within this repository. The releases listed here correspond to significant changes to the application's features. Each of the releases here is represented by a corresponding [pull request][gh-help-pull-requests]._

### v[0.4.0] Users can edit content of résumé

[View pull request](../../pull/2).
[Download release](https://github.com/codeunion/linkedout-example/archive/v0.4.0.zip).

- [X] User can view a résumé show page
- [X] Résumé show page displays user profile info, skills, and jobs
- [X] User can edit user profile
- [X] User can edit jobs
- [X] User can edit skills

### v[0.6.0] Improvements to styles and markup

[View pull request](../../pull/3).
[Download release](https://github.com/codeunion/linkedout-example/archive/v0.6.0.zip).

- [X] Site looks not-so-terrible
- [X] HTML is modularized with sections and partials

### v[0.8.0] User can add skills and jobs

[View pull request](../../pull/4).
[Download release](https://github.com/codeunion/linkedout-example/archive/v0.8.0.zip).

- [X] User can add skills directly from the résumé show page
- [X] User can add jobs directly from the résumé show page

### v[1.0.0] Skills and jobs created asynchronously

[View pull request](../../pull/5).
[Download release](https://github.com/codeunion/linkedout-example/archive/v1.0.0.zip).

- [X] User may add skills directly on their résumé show page
- [X] Adding skills does not require a page refresh
- [X] Added skills immediately show on the page in the appropriate spot
- [X] User may add jobs directly to their résumé show page, including the job title, description, and company name
- [X] Adding jobs does not require a page refresh
- [X] Added jobs immediately show on the page in the appropriate spot

This is the first release with JavaScript and jQuery included. As a reference, here are some of the resources used to accomplish the features in this release:

- Sending POST requests with AJAX: [API documentation for the `jQuery.post()` function][jquery-api-post] (make sure to read some of the examples)
- Adding content to the DOM with jQuery: [Documentation for jQuery's `.append()` function][jquery-api-append]
- Reading and serializing data from a form in jQuery: [jQuery's `.serialize()` function][jquery-api-serialize]

### v[1.2.0] Asynchronously edit and delete jobs

[View pull request](../../pull/6).
[Download release](https://github.com/codeunion/linkedout-example/archive/v1.2.0.zip).

- [X] User can edit jobs on the résumé show page
- [X] User can delete jobs on the résumé show page
- [X] Editing jobs occurs asynchronously
- [X] Deleting jobs occurs asynchronously
- [X] Edited jobs are updated on the page without refresh
- [X] Deleted jobs are removed from the page without refresh

### v[1.3.0] Asynchronously delete skills

[View pull request](../../pull/7).
[Download release](https://github.com/codeunion/linkedout-example/archive/v1.3.0.zip).

- [X] User can delete skills on the résumé show page
- [X] Deleting skills occurs asynchronously
- [X] Deleted skills are removed from the page without refresh

This release also makes improvements to the underlying architecture of the application, including the following changes:

- [X] Use [RESTful routing](http://en.wikipedia.org/wiki/Representational_state_transfer#Applied_to_web_services) conventions
- [X] Logging in `skills.js`
- [X] Format of HTML and JavaScript more consistent

In addition, the `/resumes/edit` page has been changed to `/users/edit` and now contains only a form to edit the user profile. This change removes redundancy in editing other resources.

### v[1.5.0] Display education information

- [ ] Résumé show page displays a users education history
- [ ] User can have many schools
- [ ] Schools belong to a user
- [ ] Schools have a name, graduation year, and subjects studied

### v[1.8.0] Full asynchronous CRUD for schools

- [ ] User can add schools on the résumé show page
- [ ] User can edit schools on the résumé show page
- [ ] User can delete schools on the résumé show page
- [ ] Creating, editing, and deleting schools occurs asynchronously
- [ ] Added schools show on the page in the appropriate spot without refresh
- [ ] Edited schools are updated on the page without refresh
- [ ] Deleted schools are removed from the page without refresh

### v[1.9.0] Improve the UI

- [ ] Page has pretty colors and fonts
- [ ] Design follows [fundamentals of User Interface design](http://blog.teamtreehouse.com/10-user-interface-design-fundamentals)

### v[2.0.0] Filter by skill

- [ ] User can search for other users by a specific skill
- [ ] Clicking on a skill links to a page listing all users with that skill at a URL like `/skills/web-development`

[sqlite3-install]:https://github.com/codeunion/fundamentals-of-web-development/wiki/Resources-and-Tools#sqlite
[jquery-api-post]:http://api.jquery.com/jquery.post/
[jquery-api-append]:http://api.jquery.com/append/
[jquery-api-serialize]:http://api.jquery.com/serialize/
[gh-help-releases]:https://help.github.com/articles/about-releases/
[gh-help-pull-requests]:https://help.github.com/articles/using-pull-requests/
