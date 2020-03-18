clear; close all;
x = sym('x', [2 1]);
syms f real

f = [            x(1)*x(2) - 2;
        x(1).^4/4 + x(2).^3/3 - 1];
J = jacobian(f, x);

f = matlabFunction(f, 'Vars', {x});
J = matlabFunction(J, 'Vars', {x});

x0 = [-1; -1];

Z = NewtonsMethodTemplate(f, J, x0);

r = max(abs(Z));

figure;
    semilogy(r); grid on;
    ylabel('Residual $||\mathbf{f}(\mathbf{x}_k)||_{\infty}$', 'Interpreter', 'latex', 'fontsize', 16)
    xlabel('Iteration number $n$', 'Interpreter', 'latex', 'fontsize', 16)
    title('Problem 1b');
