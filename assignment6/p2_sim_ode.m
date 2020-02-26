clear; close all;

N = 3;

a = 1e-3;
e = logspace(-3, -6, N);
tspan = [0 10];
x0 = ones(4, 1);
vars = ["$x_1$", "$x_2$", "$z_1$", "$z_2$"];

for i = 1:N
   
    [t, y] = ode15s(@(t, x) f(t, x, e(i), a), tspan, x0);
    figure(i);
    sgtitle("$\epsilon = 10^{" + log10(e(i)) + "}$", 'Interpreter', 'latex', 'fontsize', 16)
        for j = 1:4
            subplot(2, 2, j);
            plot(t, y(:, j));
            grid on;
            title(vars(j), 'Interpreter', 'latex', 'fontsize', 14);
        end
end



function x_dot = f(t, x, e, a)

    x_dot = zeros(4, 1);

    A = [x(1)^2,    x(2);
              0, x(2)^2];
          
    A = A + a*eye(2);
    
    x_dot(1:2) = -[1, 1; 0, 1]*x(1:2) - x(3:4);
    x_dot(3:4) = ( 1/10 * x(1:2) - A*x(3:4) ) / e;          

end