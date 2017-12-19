![senator Palpatine](vendor/images/do-it.gif)

This app aims to help you save, order and prioritize your `tasks`.
The app is partly inspired by the [answer](https://www.quora.com/How-do-I-get-motivated-every-single-day/answer/John-Michael-Domingo?share=1b585c6e&srid=Z4Cc) on Quora.

# Main tools
* `Ruby on Rails` for back-end
* `React` for front-end
* `Webpack` to bundle javascripts
* `Sass` for styles
* `jQuery` to fasten coding on js
* `Babel` to transpile es6 code into browser compatible code
* `Bourbon` sass mixins library

# TODO
- [ ] User registration
- [ ] Add task, list, collections
- [ ] Task or collections duration
- [ ] Completion rate - some fancy graph to show progress
- [ ] Reminder - for task bound to particular time
- [ ] Task ordering, prioritization
- [ ] Choose frontend framework for styles
- [ ] Different ways of searching tasks

# Components
## Collection
By default, there will be one list of tasks in collection, but user should be able to add more.
Collection will consist of:
* Title
* Duration
* Progress - completion rate of all tasks in this collection
* Lists
* All tasks

## List
List is a way of grouping tasks of the collection.
* Title
* Progress - Number of tasks finished and left.
* Tasks

## Task
Description of what user should do.
* Title
* Description - just text or list of todos
* Duration
* Priority
* Order
* Color according to priority

## User
Only registered users can create tasks for the first time.
* full name
* email
* password
* avatar or any image

# Future plans
* Users can share his collections, list or tasks with others,
* Create public lists to help other users use your tasks as boilerplate,
* Rate public tasks,
* Commenting components.
* Opportunities to create anonymous, temporal tasks.

# Have you finished your tasks today?
![senator Palpatine](vendor/images/good.gif)

# License
