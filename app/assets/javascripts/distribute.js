function Task(func) {
    this.func = func;
}

function run_task_and_post_result(){
    var result = run_task();
    post_result(result);
};

function run_task() {
    return nextTask.func();
}

function post_result(result) {
    // assume result is dict for now
    result["distributed_task_id"] = distributed_task_id;
    $.ajax({
        type: 'POST',
        url: 'tasks/result',
        data: result,
    });
}

function success() {
    run_task_and_post_result();
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
