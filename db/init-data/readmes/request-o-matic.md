## Request-o-Matic

You can use this trusty command line utility to request intermittent **feedback** on your code.



### To make Request-o-Matic work, you will need to do a few things.

Clone this repository directly, don't fork it.

```shell
git clone git@github.com:codeunion/request-o-matic.git
```

Request-o-matic must be run from inside the project's application root, ie, the directory that you get once you `git clone git@github.com:codeunion/request-o-matic.git`

```shell
cd request-o-matic
pwd
```

![http://cl.ly/image/2x213i0z0o3F/Image%202014-08-04%20at%205.54.03%20PM.png](http://cl.ly/image/2x213i0z0o3F/Image%202014-08-04%20at%205.54.03%20PM.png)

Always install project Gems

```shell
bundle install
```

- Make sure this project has a `.env` file located in the root of the application that has a functioning `GITHUB_ACCESS_TOKEN`.

- If you are running this project for the first time, there may be a file called `.env.example` convert that file to the actual `.env` file by typing at the command line:

```shell
cp .env.example .env
```

![http://cl.ly/image/3I131y0e0q0t/Image%202014-08-04%20at%206.02.46%20PM.png](http://cl.ly/image/3I131y0e0q0t/Image%202014-08-04%20at%206.02.46%20PM.png)


- For instructions on how to get your `GITHUB_ACCESS_TOKEN` [watch this tutorial][github-access-token]

- Paste your `GITHUB_ACCESS_TOKEN` into the `.env`, save the file.

```shell
GITHUB_ACCESS_TOKEN="9873sdlfkjald09238093428lskjfalkdjexampletoken"
```

## Request-o-Matic  `feedback`


### To submit a request for feedback on your code:

Submitting small, frequent requests for code feedback is the lifeblood of your progression to becoming a functional developer.  CodeUnion's singular goal is to get you writing code, good code, bad code, silly code, happy code, sad code, fun code, crazy code, we don't care.  We just want code, code, code.  Getting feedback on your code and having your conceptual understanding of what is happening challenged will make you a good developer.

A request for feedback can be submitted in the below fashion, `--url` is required.

```shell
bundle exec ./request-o-matic feedback --url "https://github.com/jcdavison/weekly-katas/commit/2d2a19deb558adc573f9e5ac1e71ecefbb16bcca"
```


### [Tutorial on Submitting Individual Commits for Feedback][individual-commits].


[![count in list video](https://i.ytimg.com/vi/ymeb1GXZIvk/0.jpg)](http://youtu.be/ymeb1GXZIvk?vq=hd1080)

[github-access-token]:http://quick.as/rmxlubjv
[individual-commits]:http://youtu.be/ymeb1GXZIvk
