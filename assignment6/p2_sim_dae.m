clear; close all;

syms x1(t) x2(t) z1(t) z2(t) a

x = [x1; x2];
z = [z1; z2];
vars = [x; z];

M = [1, 1;
     0, 1];

A = [x1^2,   x2;
        0, x2^2];
A = A + a*eye(2);
 
eq1 = diff(x) == -M*x - z;
eq2 = 0 == 1/10 * x - A*z;
eqns = [eq1; eq2];

[eqns,vars] = reduceDifferentialOrder(eqns,vars);

if ~isLowIndexDAE(eqns, vars)
    [DAEs,DAEvars] = reduceDAEIndex(eqns,vars);
    [DAEs,DAEvars] = reduceRedundancies(DAEs,DAEvars);
else
    DAEs = eqns;
    DAEvars = vars;
end

[M,f] = massMatrixForm(DAEs,DAEvars);
    
pDAEs = symvar(DAEs);
pDAEvars = symvar(DAEvars);
extraParams = num2cell(setdiff(pDAEs, pDAEvars));
M = odeFunction(M, DAEvars);
f = odeFunction(f, DAEvars, extraParams{:});

a = 1e-3;
tspan = [0 10];
x0 = ones(4, 1);
vars = ["$x_1$", "$x_2$", "$z_1$", "$z_2$"];

[t, y] = ode15s(@(t, x) f(t, x, a), tspan, x0);
figure(1);
    for j = 1:4
        subplot(2, 2, j);
        plot(t, y(:, j));
        grid on;
        title(vars(j), 'Interpreter', 'latex', 'fontsize', 14);
    end



