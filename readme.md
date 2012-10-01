# Distributed JS

## Distributes tasks to multiple browsers

### Goals
- browsers execute arbitrary tasks and return results to browser
- server manages queue. from db?
- things are added to queue only by the server (clients adding tasks
  is a non-goal for now)

### Todo
- given js functions, distribute them to clients
- allow someone to add function to queue
- store queue somewhere
- store results somewhere
- handle locking?
- allow for parameters to be passed in
