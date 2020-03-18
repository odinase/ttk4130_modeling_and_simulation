clear; 
% close all;
syms f real
x = sym('x', [2 1]);

f = [x(1) - 1 + (cos(x(2)).*x(1) + 1).*cos(x(2));
         -x(1).*sin(x(2)).*(cos(x(2)).*x(1) + 1)];

J = jacobian(f, x);

f = matlabFunction(f, 'Vars', {x});
J = matlabFunction(J, 'Vars', {x});

x0 = [1; 3];

Z = NewtonsMethodTemplate(f, J, x0);

r = max(abs(Z));

figure;
    semilogy(r); grid on;
    ylabel('Residual $||\mathbf{f}(\mathbf{x}_k)||_{\infty}$', 'Interpreter', 'latex', 'fontsize', 16)
    xlabel('Iteration number $n$', 'Interpreter', 'latex', 'fontsize', 16)
    title('Problem 1d')