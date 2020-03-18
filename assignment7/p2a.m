%% Setup sim

clear; close all;
lambda = -2;
f = @(t, x) lambda*x;
dt = 0.4;
T0 = 0;
Tf = 2;
T = linspace(T0, Tf, (Tf - T0) / dt);
Nt = length(T);
x0 = 1;
X.true = x0*exp(lambda*T);

%% SIM: ERK1

b = 1;
c = 0;
A = 0;
BT = struct('A', A, 'b', b, 'c', c);
X.erk1 = ERKTemplate(BT, f, T, dt, x0);

%% SIM2: ERK2

b = [0 1]';
c = [0 1/2]';
A = [  0, 0;
     1/2, 0];
BT = struct('A', A, 'b', b, 'c', c);
X.erk2 = ERKTemplate(BT, f, T, dt, x0);

%% SIM3: ERK4

b = [1/6, 1/3, 1/3, 1/6]';
c = [0 1/2 1/2 1]';
A = [  0,   0, 0, 0;
     1/2,   0, 0, 0;
       0, 1/2, 0, 0;
       0,   0, 1, 0];
BT = struct('A', A, 'b', b, 'c', c);
X.erk4 = ERKTemplate(BT, f, T, dt, x0);

%% Plot results

figure(1); clf;
    plot(T, X.erk1(:), '--*');
    hold on;
    plot(T, X.erk2(:), '--o');
    hold on;
    plot(T, X.erk4(:));
    hold on;
    plot(T, X.true(:));
    hold on;
    legend("ERK1", "ERK2", "ERK4", "True trajectory", "location", "best");
    
