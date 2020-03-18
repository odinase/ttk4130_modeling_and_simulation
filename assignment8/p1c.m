clear; 
% close all;
syms x f real


f = (x - 1).*(x - 2).*(x - 3) + 1;

J = jacobian(f, x);

f = matlabFunction(f, 'Vars', {x});
J = matlabFunction(J, 'Vars', {x});

x0 = 3;

Z = NewtonsMethodTemplate(f, J, x0);

r = abs(Z);

figure;
    semilogy(r); grid on;
    ylabel('Residual $||\mathbf{f}(\mathbf{x}_k)||_{\infty}$', 'Interpreter', 'latex', 'fontsize', 16)
    xlabel('Iteration number $n$', 'Interpreter', 'latex', 'fontsize', 16)
    title('Problem 1c')
