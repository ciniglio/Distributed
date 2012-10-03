# Distributed JS

## Distributes tasks to multiple browsers

### Usage
- Provide tasks.js files in app/tasks
- task*.js must define `var nextTask = new Task(main_function_name)`
- `main_function_name` *must* return a dictionary

### Goals
- browsers execute arbitrary tasks and return results to browser
- server manages queue. from db?
- things are added to queue only by the server (clients adding tasks
  is a non-goal for now)

### Todo
- allow for parameters to be passed in
  
