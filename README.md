# eval: Code Review Report Generator

The purpose of ```eval``` is to diagnose code issues in large-scale projects through one comprehensive automated 
review rather than many partial manual reviews by developers. The goal is to save time reviewing code, 
organize and classify errors, and produce the output in a Google Doc for users to view and edit. The project is a Ruby-based code 
review report generator that processes programs written in Ruby, PHP, and Java using the FOSS technologies listed below.

# Usage
```
thor eval:analyze PATH_TO_DIRECTORY
```

# Dependencies
### CLI
- [Thor](https://github.com/erikhuda/thor) : a simple and efficient tool for building self-documenting command line utilities

### FOSS
- [Churn](https://github.com/danmayer/churn) : a tool for measuring high-churn code in Git
- [OWASP](https://github.com/OWASP) : a static code analyzer for identifying security vulnerabilities in Java and Ruby web applications
- [Rubocop](https://github.com/rubocop-hq/rubocop) : a Ruby static code analyzer and formatter, based on the community Ruby style guide
- [Checkstyle](https://github.com/checkstyle/checkstyle) :  a development tool to help programmers write Java code that adheres to a coding standard
- [PHPLint](https://github.com/overtrue/phplint) : a Node wrapper around the native PHP linter

### API
- [Google Drive](https://developers.google.com/drive) : an API for creating applications that read, write, and sync files in Google Drive

# The Team
The team is Jason Brito, Tony Lin, Lawrence Kwok, and Nick Michuda, and this is our senior design project, sponsored by Dave Lane of Inventiv, for 
the Vanderbilt University School of Engineering.
