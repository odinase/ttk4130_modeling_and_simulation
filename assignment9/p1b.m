clear; close all;
% x = sym('x', [2 1]);
syms f x t real
lambda = 2;

f = -lambda*x;
J = jacobian(f, x);

f = matlabFunction(f, 'Vars', [t, {x}]);
dfdx = matlabFunction(J, 'Vars', [t, {x}]);

t0 = 0;
tf = 2;
dt = 0.4;
Nt = (tf - t0) / dt;
T = linspace(t0, tf, Nt);
x0 = 1;

A = [          1/4, 1/4-sqrt(3)/6;
     1/4+sqrt(3)/6,           1/4];
c = [1/2 - sqrt(3)/6; 1/2 + sqrt(3)/6];
b = [1/2; 1/2];

ButcherArray.A = A;
ButcherArray.b = b';
ButcherArray.c = c;


X = IRKTemplate(ButcherArray, f, dfdx, T, x0);

xtrue = x0*exp(-lambda*T);
plot(T, xtrue, T, X);
legend('True', 'IRK');