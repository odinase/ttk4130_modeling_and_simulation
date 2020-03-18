clear; 
% close all;
syms t x f real
% x = sym('x', [1 1]);
lambda = -2;

f = lambda*x;
dfdx = jacobian(f, x);

f = matlabFunction(f, 'Vars', [t, x]);
dfdx = matlabFunction(dfdx, 'Vars', [t, x]);

x0 = 1;
t0 = 0;
tf = 2;
dt = 0.2;
T = linspace(t0, tf, (tf - t0) / dt);

Z = ImplicitEulerTemplate(f, dfdx, T, x0);
x_true = exp(lambda*T);

figure;
    plot(T, Z); hold on;
    plot(T, x_true);
    legend('Implicit Euler', 'True trajectory')
    title('Problem 2b')
    

% r = max(abs(Z));

% figure;
%     semilogy(r); grid on;
%     ylabel('Residual $||\mathbf{f}(\mathbf{x}_k)||_{\infty}$', 'Interpreter', 'latex', 'fontsize', 16)
%     xlabel('Iteration number $n$', 'Interpreter', 'latex', 'fontsize', 16)
