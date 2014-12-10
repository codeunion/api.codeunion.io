# blog.codeunion.io

This is the CodeUnion blog hosted at <http://blog.codeunion.io>.

## Kramdown

**Note**: This section isn't accurate.  For some reason, Kramdown isn't playing nicely with fenced code blocks in production.  See <https://github.com/jekyll/jekyll/issues/2676>.  For now, we're using [Redcarpet](https://github.com/vmg/redcarpet) to parse Markdown.

Like GitHub Pages, we're using [kramdown](https://github.com/gettalong/kramdown) to parse our Markdown files.  The syntax is likely more prescriptive than you're used to.

See [the kramdown syntax guide](http://kramdown.gettalong.org/syntax.html).  In particular, when you're creating lists, it's important everything is indented the same level at 4 spaces.  Like so:

```markdown
1.  First list item. (Notice the two spaces after the period).

    Look, a paragraph!  Notice that it's indented 4 spaces.

    Here's some Ruby:

    ```ruby
    def greet(name)
      puts "Greetings, #{name}!"
    end
    ```
2.  Second list item.

    Notice the indentation.  It has to be exact.
```

## Creating a New Post

Run

```console
$ rake posts:create TITLE="The Best Blog Post Ever"
```

to create a new (empty) post in `_posts`.

## Running Jekyll

To run Jekyll, do

```console
$ bundle exec jekyll server --watch
```

and visit <http://localhost:4000>.
