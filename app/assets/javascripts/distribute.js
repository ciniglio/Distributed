function Task(func) {
    this.func = func;
    this.execute = function(){
        this.func();
    }
}

function sum2() {
    return 1+1;
}

var mytask = new Task(sum2);
alert('I am' + mytask.execute());
