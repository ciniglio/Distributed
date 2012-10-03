function Car() {
    this.wheels = 4;
    this.say = function(name) {
        alert('this is a car, ' + name);
    };
};

function mustang(size, name) {
    var c = new Car();
    return {"car_wheels": c.wheels,
            "car_name": "Mustang",
            "car_size": size,
            "car_owner": name,
            };
};

var nextTask = new Task(mustang);
