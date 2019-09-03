# to-do-list-sinatra-project
A basic to-do list app built with Sinatra and ActiveRecord

App flow:

  - Login or sign up on home page. Usernames must be unique.
    - Once logged in, you'll see the user index page. Here you will find links to view your existing lists (if any), create a new list, or log out.
      - Create A New To-Do List
        - titles must be unique; they are not case-sensitive
        - tasks do not have to be unique
        - after you submit, you will be redirected to the list's show page.
      - View Your To-Do Lists: you will be redirected to a page with your existing list titles (lists index page). Click a title to view the full list with tasks.
      - On the list's show page, you may:
        - edit the title and/or the tasks' text contents
        - check off tasks to remove them
        - add up to five new tasks at a time
        - changes will save when you click the "Update List" button
        - click "Delete List" button to delete list. You will be redirected to lists index page.
        - go back to lists index page

* TL;DR: works how you would expect it to, and each page has directions or calls to action.
