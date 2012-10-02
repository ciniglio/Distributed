var distributed_parameters;

function setup(){
    distributed_parameters = [];
}

function Task(func) {
    this.func = func;
}

function run_task_and_post_result(){
    var result = run_task();
    post_result(result);
};

function run_task() {
    return nextTask.func.call({}, distributed_parameters);
}

function post_result(result) {
    // assume result is dict for now
    data = {};
    data["result"] = JSON.stringify(result);
    data["distributed_task_id"] = distributed_task_id;
    $.ajax({
        type: 'POST',
        url: 'tasks/result',
        data: data,
        success: get_new_task,
    });
}

function success() {
    run_task_and_post_result();
}

function failure() {
    alert ('failure');
}

function main() {
    setup();
    get_new_task();
}

function wait_then_get_new_task(){
    window.setTimeout(get_new_task, 10000);
}

// call url to get new task
function get_new_task(){
    $.ajax({
        url: 'tasks/next',
        success: success,
        error: wait_then_get_new_task,
        datatype: "script",
    });
};

main();

// assign task to task object

// execute task

// return result via post
