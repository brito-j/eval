# eval: Code Review Report Generator

The goal of our project is to diagnose coding issues within larger-scale projects through a comprehensive automated 
process instead of manual code reviews by software engineers. The end objective is to reduce time spent on manual reviews, 
organize and classify errors, and deliver the output to a Google Doc for users to view. The project is a Ruby-based code 
review generator which will process programs written in Ruby, PHP, and Java by using FOSS technologies listed below.

# Usage
```
thor eval:analyze DIRECTORY_PATH
```

# Dependencies
### Ruby
- [Thor](https://github.com/erikhuda/thor) : a simple and efficient tool for building self-documenting command line utilities.

### Tools for Analysis
- [Churn](https://github.com/danmayer/churn) : analyzes git project history to find high-churn areas of code.
- [OWASP](https://github.com/OWASP) : a static code analyzer for identifying security vulnerabilities in Java and Ruby web applications.
- [Rubocop](https://github.com/rubocop-hq/rubocop) : a static code analyzer and code formatter.
- [Checkstyle](https://github.com/checkstyle/checkstyle) : a static code analyzer and code format enforcer.
- [PHPLint](https://github.com/overtrue/phplint) : a static code analyzer and linter.

### Google Drive API
- Google Docs

# The Team
Primary members are Jason Brito, Tony Lin, Lawrence Kwok, and Nick Michuda. This is our senior design project for 
the Vanderbilt University School of Engineering and is sponsored by Dave Lane of Inventiv.
