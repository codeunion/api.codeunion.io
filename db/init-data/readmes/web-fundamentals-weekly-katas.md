# Weekly Code Katas

A <dfn>code kata</dfn> is an exercise in programming which helps a programmer hone their skills through practice and repetition. Most of our katas are designed be completed in less than an hour by someone with appropriate prior knowledge.

Each week we'll release a new batch of katas designed to complement the concepts you'll need to work on your projects for that week.  Katas are a *great* way to get the week started, test or verify your own understanding, and get quick feedback from your teachers.

We *do not* expect students to complete every kata every week, but you should be attempting as many as you can.  **Remember**, the top priority is getting feedback from us, even if your code is incomplete.

## Contents

1. [How to Approach Katas](#how-to-approach-katas)
1. [Getting Started](#getting-started)
  1. [Forking This Repository](#forking-this-repository)
1. [Katas by Week](#katas-by-week)
  1. [Week 1](#week-1)
    1. [What should I focus on this week?](#what-should-i-focus-on-this-week)
    1. [What am I ok ignoring for now?](#what-am-i-ok-ignoring-for-now)
    1. [The Katas for Week 1](#the-katas-for-week-1)
  1. [Week 2](#week-2)
    1. [The Katas for Week 2](#the-katas-for-week-2)
1. [A Note on StackOverflow and Similar Sites](#a-note-on-stackoverflow-and-similar-sites)

## How to Approach Katas

If you have one thing in mind when working on these katas it should be this: we've never once encountered a student who asked for _too much_ feedback.  Not once.

Our goal is preparing these katas is not to ensure that you "get them right," but to establish well-calibrated and productive code→feedback→refactor loop. If you're not sure how to do that, here's a structure we recommend:

1. Set aside a fixed amount of time: 30, 45, or 60 minutes
1. Pick a kata that interests you
1. Make as much progress as you can in that amount of time
1. When time runs out, publish your code and ask us for feedback

As always, if you have any questions or feel stuck, you should send an email to your cohort's mailing list, <stuck@codeunion.io>, or one of your teachers. There are no rules against using Google or StackOverflow to help you with these katas, but please read [our note on StackOverflow and similar sites](#a-note-on-stackoverflow-and-similar-sites) first.

## Getting Started

You need to be able to run Ruby code in order to do these katas.  You may or may not have Ruby set up on your local computer.  If you **don't**, [read these instructions on setting up your local development environment](https://gist.github.com/jfarmer/484c21cf93a27cd9dcff).  In the meantime, we recommend using [repl.it's online Ruby environment](http://repl.it/languages/Ruby).  You can paste any of the code you see below into the left-hand pane you'll find there and click the "arrow" above it to run the code.  The output will appear in the right-hand pane.

### Forking This Repository

To get started, you need to create your own copy of the katas.  To do this you need to **fork** the main repository at [https://github.com/codeunion/weekly-katas][weekly-katas-repo].  This will create a copy of the weekly-katas repository under your own GitHub account.

To do this, go to the [weekly-katas repository on GitHub][weekly-katas-repo]. In the upper-right hand corner you should see a button labeled "Fork", like this:

<p style="text-align:center">
<img src="http://f.cl.ly/items/2W3G2W3U0E2f3v1a0a0K/Screen%20Shot%202014-03-03%20at%202.21.15%20PM.png" alt="Fork button">
</p>

**Click the button** and this will create a new repository under your own GitHub account. The number next to the button indicates how many times this repository has been forked, so it might be a different number.

## Katas by Week

The repository contains a collection of individual Ruby (`.rb`) files, each of which contains a single kata. Each kata is self-contained and self-documenting.  For each week we provide you with a *suggested* order, but you should feel free to do them in any order you like.  We'll make it very clear when we intend for a kata to depend on a previous kata.

### Week 1

1. [What should I focus on?](#what-should-i-focus-on-this-week)
1. [What am I ok ignoring for now?](#what-am-i-ok-ignoring-for-now)
1. [The Katas](#the-katas-for-week-1)

#### What should I focus on this week?

The first week serves as a "crash course" in Ruby fundamentals and the overall workflow of our workshop.  In order of importance, you should be focusing on:

1. Getting code reviews and feedback from your teachers
1. Getting code reviews and feedback from your teachers
1. Getting code reviews and feedback from your teachers (sensing a pattern?)
1. Developing good habits with the tools you'll be using every day, especially Sublime Text, the command line, and GitHub.
1. Understanding the programming fundamentals via Ruby, particularly
  - **Data and Basic Data Types**
    - Variables and variable assignment
    - Numbers, strings, booleans, `nil`
    - Arrays (`[1,2,3]`), Hashes (`{:name => "Jesse", :age => 30}`)
  - **Essential Program Flow / Control**
    - Branching (`if`, `else`)
    - Looping & iteration (`list.each do |item| ... end`)
    - Defining, calling, and returning from methods (`def my_method(a,b,c) ... end`)

#### What am I ok ignoring for now?

You might feel compelled to focus on some or all of the following.  Don't!

1. Code performance, e.g., "Can I make this faster?"
1. Code elegance or cleverness
1. What your teachers will "think of you" when they see your code
1. How your work will compare to your fellow students'

We know this is easier said than done, so use this list as a check for when you find yourself stalling.  Are you hung up because you're worried about one of the above?

#### The Katas for Week 1

1. [max.rb](week-01/max.rb)
1. [min.rb](week-01/min.rb)
1. [longest_string.rb](week-01/longest_string.rb)
1. [shortest_string.rb](week-01/shortest_string.rb)
1. [sum.rb](week-01/sum.rb)
1. [mean.rb](week-01/mean.rb)
1. [count_in_list.rb](week-01/count_in_list.rb)
1. [count_max.rb](week-01/count_max.rb)
1. [word_count.rb](week-01/word_count.rb)
1. [print_square.rb](week-01/print_square.rb)
1. [print_triangle.rb](week-01/print_triangle.rb)
1. [print_pyramid.rb](week-01/print_pyramid.rb)
1. [print_horizontal_pyramid.rb](week-01/print_horizontal_pyramid.rb)
1. [hot_or_cold.rb](week-01/hot_or_cold.rb)

### Week 2

Remember, the focus is on using the katas to receive feedback!

#### The Katas for Week 2

See also [week-02/SUGGESTED-ORDER](week-02/00-SUGGESTED-ORDER.md).

1. [bottles.rb](week-02/bottles.rb)
1. [find_even.rb](week-02/find_even.rb)
1. [mode.rb](week-02/mode.rb)
1. [commas.rb](week-02/commas.rb)
1. [factorial.rb](week-02/factorial.rb)
1. [fibonacci.rb](week-02/fibonacci.rb)
1. [find_links.rb](week-02/find_links.rb)
1. [find_title.rb](week-02/find_title.rb)
1. [pig_latin.rb](week-02/pig_latin.rb)
1. [pad_array.rb](week-02/pad_array.rb)

### Week 2

#### What should I focus on this week?

This week we're going to push our first web application live right from the get-go.
From here one out, we'll mostly be playing "on the web."

1. As always, feedback, feedback, feedback!
2. Getting comfortable making changes to your appplication and deploying it.
3. Understanding how the "execution flow" differs in a web application vs.
   the command-line applications you've been writing so far.

#### The Katas for Week 3

The katas this week are more challenging than those of previous weeks. If you
find them too challenging, focus on the project!

See also [week-03/SUGGESTED-ORDER](week-03/00-SUGGESTED-ORDER.md).

1. [time_format.rb](time_format.rb)
2. [run_length_encode.rb](run_length_encode.rb)
3. [run_length_decode.rb](run_length_decode.rb)
4. [rot13.rb](rot13.rb)
5. [rot_n.rb](rot_n.rb)
6. [to_english.rb](to_english.rb)
7. [to_roman.rb](to_roman.rb)

## A Note on StackOverflow and Similar Sites

With a little bit of Google-fu, you can easily find working Ruby code for many of our katas on sites like StackOverflow, especially the ones earlier in the workshop.  It's not "against the rules" to copy and paste from StackOverflow, but don't do it blindly.

In particular, ask yourself two questions:

1. Why am I doing this?
1. Could I articulate what each line of code in this "solution" does?

If you're copying and pasting because you want to "get the answer", "finish the kata," or "not make any mistakes", please don't!  The *point* of these katas is for you to develop habits that will serve you in the future, when the problems you're encountering will be much more complex.  It'd be 100x better for you to ask for feedback on an incomplete, non-working kata than to ask for feedback on a working kata whose code you found on StackOverflow.

Better yet, try as hard as you can to get into a mindset where you're *excited* by the prospect of making a mistake.  That's where learning happens! :)

That said, you know your own learning style better than we possibly could.  Many students learn by first seeing working examples.  We've tried to provide some, here, but it's never possible to cover every possible case beforehand.  Sometimes you'll want to find examples on your own and use them once you fully understand them.  That's where the second question comes in: can you *really, truly* articulate what each line of code in the example does?


[weekly-katas-repo]:https://github.com/codeunion/weekly-katas
