clear; close all;
a = 1e-3;
tspan = [0 10];
x0 = ones(2, 1);
vars = ["$x_1$", "$x_2$", "$z_1$", "$z_2$"];

[t, y] = ode15s(@(t, x) f(t, x, a), tspan, x0);
% A = [y(:,1)^2,    y(:,2);
%               0,  y(:,2)^2];
%           
% A = A + a*eye(2);


% y(:, 3:4) = A\(1/10*y);
    for j = 1:2
        subplot(1, 2, j);
        plot(t, y(:, j));
        grid on;
        title(vars(j), 'Interpreter', 'latex', 'fontsize', 14);
    end

function x_dot = f(t, x, a)
    x_dot = zeros(2, 1);

    A = [x(1)^2,    x(2);
              0, x(2)^2];
          
    A = A + a*eye(2);
    
    x_dot(1:2) = -[1, 1; 0, 1]*x(1:2) - A\(1/10*x(1:2));
end