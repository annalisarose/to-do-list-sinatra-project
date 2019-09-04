# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
    - in Gemfile and in environment
    - MVCs follow appropriate syntax
    - Application controller inherits from Sinatra::Base
- [x] Use ActiveRecord for storing information in a database
    - in Gemfile and in environment
    - DB connects to ActiveRecord
    - all classes inherit appropriate methods from ActiveRecord
- [x] Include more than one model class (e.g. User, Post, Category)
    - Three model classes: User, List, Checkitem
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    - User has_many Lists, has_many Checkitems through Lists
    - List has_many Checkitems
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
    - List belongs_to User
    - Checkitem belongs_to List
- [x] Include user accounts with unique login attribute (username or email)
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
- [x] Ensure that users can't modify content created by other users
- [x] Include user input validations
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message
- [ ] You don't include changes in a commit that aren't related to the commit message
