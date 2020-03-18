clear; 
% close all;
syms f real
x = sym('x', [2 1]);

F = 100.*(x(2) - x(1)).^2 + (x(1) - 1).^4;
f = jacobian(F, x)';
J = jacobian(f, x);

F = matlabFunction(F, 'Vars', {x});
f = matlabFunction(f, 'Vars', {x});
J = matlabFunction(J, 'Vars', {x});

x0 = [10; 10];

Z = NewtonsMethodTemplate(f, J, x0);

r = max(abs(Z));

figure;
    semilogy(r); grid on;
    ylabel('Residual $||\mathbf{f}(\mathbf{x}_k)||_{\infty}$', 'Interpreter', 'latex', 'fontsize', 16)
    xlabel('Iteration number $n$', 'Interpreter', 'latex', 'fontsize', 16)
    title('Problem 1e')
