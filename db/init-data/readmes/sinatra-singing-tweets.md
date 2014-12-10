### Sinatra Likes to Sing...

### and by Singing I mean TWEETING!

This little app will help CodeUnion evaluate your understanding of the client/server roundtrip process.

We want to make sure that you know how to get CRUD(y), ie, Create, Read, Update and Destroy data on a server.

We also want to make sure that you understand how rest http actions work.  Instead of using rails to do this, we'll use Sinatra, the code is simpler and hopefully will be a better indicator of your understanding of the internet versus your understanding of Ruby on Rails.

Feel free to look at the sinatra documentation if you need it, in fact, use google and any documentation that you want but whatever you do, make sure that any code you commit is yours. 

http://www.sinatrarb.com/documentation.html

Assume that this application revolves around a Tweet and yes a tweet is a small string of text.

You can run the app by issuing 'rerun -x rackup'

- Should be able to fetch a list of tweets at ```http://localhost:9292/```
- Should be able to create a tweet at ```http://localhost:9292/tweets/new```
- Should be able to show an individual tweet at ```http://localhost:9292/tweets/:id```
- Should be able to edit a tweet at ```http://localhost:9292/tweets/edit/:id```
- Should be able to destroy a tweet at ```DELETE http://localhost:9292/tweets/:id```

Assume that the application is supposed to function like the above 'should' statements but there are some bugs.  You are the role of happy developer and it is your job to find as many bugs as possible.  Fix them and then push your working application back up to github.

This application uses DataMapper instead of active record, we aren't using anything crazy but DataMapper is well documented http://datamapper.org/docs/  
