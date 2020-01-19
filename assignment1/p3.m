close all;

a = 1.4e-6;
b = 3.1e-8;
b_d = 5.6e-16;
d = 2.8e-8;
i = 2.6e-6;
n = 1.4e-6;
r = 2.8e-7;
q_i = 2.7e-6;
q_z = 2.7e-6;
d_q = 2.8e-5;

H0 = (b - d) / b_d;
I0 = 0;
Z0 = 0;
D0 = 0;
Q0 = 0;

y0_no_q = [H0, I0, Z0, D0];
y0_q = [H0, I0, Z0, D0, Q0];

Tf = 100 * 3600 * 24; % days
tspan = [0, Tf];

[t_no_q, y_no_q] = ode15s(@(t, y) zombie_no_q(t, y, a, b, b_d, d, i, n, r), tspan, y0_no_q);
[t_q, y_q] = ode15s(@(t, y) zombie_q(t, y, a, b, b_d, d, i, n, r, q_i, q_z, d_q), tspan, y0_q);

figure(1);
suptitle('Without Q');
subplot(2, 2, 1);
plot(t_no_q, y_no_q(:, 1));
title('H')

subplot(2, 2, 2);
plot(t_no_q, y_no_q(:, 2));
title('I')

subplot(2, 2, 3);
plot(t_no_q, y_no_q(:, 3));
title('Z')

subplot(2, 2, 4);
plot(t_no_q, y_no_q(:, 4));
title('D')

figure(2);
suptitle('With Q');
subplot(3, 2, 1);
plot(t_q, y_q(:, 1));
title('H')

subplot(3, 2, 2);
plot(t_q, y_q(:, 2));
title('I')

subplot(3, 2, 3);
plot(t_q, y_q(:, 3));
title('Z')

subplot(3, 2, 4);
plot(t_q, y_q(:, 4));
title('D')

subplot(3, 2, 5);
plot(t_q, y_q(:, 5));
title('Q')

function dydt = zombie_no_q(t, y, a, b, b_d, d, i, n, r)

    H = y(1);
    I = y(2);
    Z = y(3);
    D = y(4);

    dydt = [b*H - b_d*H^2 - d*H - i*H*Z;
           -a*I + i*H*Z - d*I;
            r*D - n*H*Z + a*I;
            d*H + d*I + n*H*Z - r*D];

end

function dydt = zombie_q(t, y, a, b, b_d, d, i, n, r, q_i, q_z, d_q)

    H = y(1);
    I = y(2);
    Z = y(3);
    D = y(4);
    Q = y(5);

    dydt = [b*H - b_d*H^2 - d*H - i*H*Z;
           -a*I + i*H*Z - d*I - q_i*I;
            r*D - n*H*Z + a*I - q_z*Z;
            d*H + d*I + n*H*Z - r*D + d_q*Q;
            q_i*I + q_z*Z - d_q*Q];

end