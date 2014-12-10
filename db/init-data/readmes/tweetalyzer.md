### Tweetalyzer  


Learn how to turn return values from the Twitter API into relevant metrics and actionable data.

To get this application running.

1. Fork and Clone this repository.

1. Install any relevant gems.

  ```shell
  bundle install
  ```

1. Setup your `.env` file.

  ```shell
  cp .env.example .env
  ```

1.  Head to the Twitter api, register an application, get all your tokens and paste them into `.env`  

  [Tutorial on how to get your twitter tokens...][twitter-token-tutorial]

  ![http://cl.ly/image/2Y4041172H3o/Image%202014-08-06%20at%201.36.14%20PM.png](http://cl.ly/image/2Y4041172H3o/Image%202014-08-06%20at%201.36.14%20PM.png)


[twitter-token-tutorial]:https://github.com/codeunion/twitter-client/blob/master/docs/twitter.md#registering-your-application

1. Run the application

```shell
rackup
```

1. Head to `http://localhost:9292` and begin to learn about the Magic :boom:


### Useful Resources

- http://www.sinatrarb.com/
- https://dev.twitter.com/
