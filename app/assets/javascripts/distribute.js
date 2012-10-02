function Task(func) {
    this.func = func;
}

function success() {
    alert ('success');
    var result = nextTask.func();
    $.ajax({
        type: 'POST',
        url: 'tasks/result',
        data: result,
    });
}

function failure() {
    alert ('failure');
}

// call url to get new task
$.ajax({
    url: 'tasks/next',
    success: success,
    datatype: "script",
});


// assign task to task object

// execute task

// return result via post
