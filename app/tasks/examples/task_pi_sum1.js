function one_factor (n) {
    num = numerator(n);
    den = denominator(n);
    return num/den;
};

function numerator(n) {
    a = 2;
    b = Math.pow(-1,n);
    c = Math.pow(3,.5-n);
    return a*b*c;
};

function denominator(n) {
    return (2*n + 1);
};

var nextTask = new Task(numerator);
