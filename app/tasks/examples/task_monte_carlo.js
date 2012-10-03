function Point(x,y) {
    this.x = x;
    this.y = y;
    this.distance = function (other) {
        return cartesian_distance(this, other);
    };
}

var Origin = new Point(0,0);

function simulate() {
    return Origin.distance(get_random_point());
};

function get_random_point(){
    return new Point(Math.random(), Math.random());
};

function cartesian_distance(a,b) {
    dx = a.x - b.x;
    dy = a.y - b.y;
    return Math.sqrt(dx * dx + dy * dy);
};

var nextTask = new Task(simulate);
