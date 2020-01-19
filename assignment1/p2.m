close all;


t0 = 0;
tf = 5;
tspan = [t0 tf];
x1_0 = 1;
x2_0 = 0;
f1 = @(t, x) x^2;
f2 = @(t, x) sqrt(x);
[t1, x1] = ode45(f1, tspan, x1_0);
[t2, x2] = ode45(f2, tspan, x2_0);

t = t2;

x1_analytic = 1 ./ (1 - t);
x2_analytic = 0.25 * t.^2; % For strictly positive x

figure(1);
subplot(2, 1, 1);
plot(t1, x1); hold on;
plot(t, x1_analytic); 
title({'$\dot{x} = x^2$'}, 'interpreter', 'latex', 'fontsize', 14);
subplot(2, 1, 2);
plot(t2', x2'); hold on;
plot(t, x2_analytic);
title({'$\dot{x} = \sqrt{|x|}$'}, 'interpreter', 'latex', 'fontsize', 14);