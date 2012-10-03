# Distribute

## Distributes tasks to multiple browsers 

Inspired by projects like folding@home and SETI@home, this is a
framework on top of Rails that allows the server to distribute tasks
to its clients (browsers). This is best suited for highly
parallelizeable tasks such as monte-carlo simulations or other
[embarassingly parallel problems](http://en.wikipedia.org/wiki/Embarrassingly_parallel).

### Usage
- Provide tasks.js files in app/tasks
- task*.js must define `var nextTask = new Task(main_function_name)`
- The result of `main_function_name` will be saved in the db

### Verification 
Already completed tasks will run again on a new machine and the
results will be compared (about 10% of the time). This gives some
additional confidence in the results, but is by no means a security
guarantee.

Some tasks (e.g. random generations) are not well suited for
verification. For these tasks, the `rake tasksjs:repeated` command
takes an additional argument to omit verification.

### Rakefile
A Rakefile has been provided to make some common tasks easier. The
namespace is `tasksjs`.

*Note:* For rake operations that add tasks to the database, rake will
 also look for a parameters file `parameters_task*.txt` in the same
 location, and will use parameters on a single line. See more at
 [parameters](#parameters)
 
- `rake tasksjs:init` will clear all tasks from the database, then go
  through all the tasks in app/tasks and add them to the database
- `rake tasksjs:repeated` will take an argument `num` and add all the tasks
  in app/tasks `num` times.
- as noted above `rake tasksjs:repeated` will take an additional
  argument to disable verification. If you want verification to be
  disabled, you should pass "true".

#### Parameters 
The `parameters_task*.txt` file is expected to have
all the needed comma separated parameters on one line. This will then
be applied to the function in `task*.txt`, once for every line. 

A `parameters_task*.txt` like the following:
```
0, "james", "sally"
5, "john", "jerry"
```

will result in two tasks being added to the queue:
- `task*.js` with args `0, "james", "sally"`
- `task*.js` with args `5, "john", "jerry"`

### Examples
An `examples` folder has been provided in `app/tasks`. These _simple_
examples can be moved into `app/tasks` if you'd like to use them. Some
have parameters, others need to have verification disabled (monte
carlo). 

### Initial Goals
- browsers execute arbitrary tasks and return results to browser
- server manages queue from db
- things are added to queue only by the server (clients adding tasks
  is a non-goal for now)

