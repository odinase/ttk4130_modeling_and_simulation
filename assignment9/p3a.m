clear; close all;

syms f c g t z real
p = sym('p', [3 1]);
v = sym('v', [3 1]);
vd = sym('vd', [3 1]);
x = [p; v];
g = 9.81;
m = 1; 
L = 1;

f = [ v ; -g*[0 0 1]' - z/m * p];
g = p'*vd + v'*v;
J = jacobian(f, x);

f = matlabFunction(f, 'Vars', [t, z, {p, v}]);
c = 0.5 * (p'*p - L^2);
dfdx = matlabFunction(J, 'Vars', [t, {x}]);

t0 = 0;
tf = 30;
dt = 0.1;
T = linespace(t0, tf, (tf - t0) / dt);
x0 = [1 0 0 0 1 0]';

