function Car() {
    this.wheels = 4;
    this.say = function() {
        alert('this is a car');
    };
};

function mustang() {
    var c = new Car();
    return {"car_wheels": c.wheels,
            "car_name": "Mustang"};
};

var nextTask = new Task(mustang);
