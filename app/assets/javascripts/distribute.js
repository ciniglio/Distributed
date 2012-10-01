function Task(func) {
    this.func = func;
}

function sum2() {
    return 1+1;
}

var mytask = new Task(sum2);
alert('I am' + mytask.func());

function success() {
    alert ('success');
}

function failure() {
    alert ('failure');
}

// call url to get new task
$.ajax({
    url: 'tasks/next',
    success: success,
});


// assign task to task object

// execute task

// return result via post
