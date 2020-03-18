%% Setup sim

clear; close all;
lambda = -2;
f = @(t, x) lambda*x;
dt = linspace(0.4, 2.5, 12);
T0 = 0;
Tf = 10;
x0 = 1;
n_dt = length(dt);
T = cell(n_dt, 1);
for i = 1:n_dt
    T{i} = linspace(T0, Tf, (Tf - T0) / dt(i));
end

%% SIM: ERK1

b = 1;
c = 0;
A = 0;
BT = struct('A', A, 'b', b, 'c', c);
X.erk1 = cell(n_dt, 1);
for i = 1:n_dt
    X.erk1{i} = ERKTemplate(BT, f, T{i}, dt(i), x0);
end

%% SIM2: ERK2

b = [0 1]';
c = [0 1/2]';
A = [  0, 0;
     1/2, 0];
BT = struct('A', A, 'b', b, 'c', c);
X.erk2 = cell(n_dt, 1);
for i = 1:n_dt
    X.erk2{i} = ERKTemplate(BT, f, T{i}, dt(i), x0);
end

%% SIM3: ERK4

b = [1/6, 1/3, 1/3, 1/6]';
c = [0 1/2 1/2 1]';
A = [  0,   0, 0, 0;
     1/2,   0, 0, 0;
       0, 1/2, 0, 0;
       0,   0, 1, 0];
BT = struct('A', A, 'b', b, 'c', c);
X.erk4 = cell(n_dt, 1);
for i = 1:n_dt
    X.erk4{i} = ERKTemplate(BT, f, T{i}, dt(i), x0);
end

%% Get errors

e.erk1 = zeros(size(X.erk1));
for i = 1:size(X.erk1, 1)
   e.erk1(i) = sum(abs(X.erk1{i} - x0*exp(lambda*T{i})));
end
figure(4); clf;
    loglog(dt(end:-1:1), e.erk1);
    title("Error ERK1");    
    

e.erk2 = zeros(size(X.erk2));
for i = 1:size(X.erk2, 1)
   e.erk2(i) = sum(abs(X.erk2{i} - x0*exp(lambda*T{i})));
end
figure(5); clf;
    loglog(dt(end:-1:1), e.erk2); 
    title("Error ERK2");

e.erk4 = zeros(size(X.erk4));
for i = 1:size(X.erk4, 1)
   e.erk4(i) = sum(abs(X.erk4{i} - x0*exp(lambda*T{i})));
end
figure(6); clf;
    loglog(dt(end:-1:1), e.erk4);
    title("Error ERK4");


figure(7); clf;
    loglog(dt(end:-1:1), e.erk1); hold on;
    loglog(dt(end:-1:1), e.erk2); hold on;
    loglog(dt(end:-1:1), e.erk4);
    title("Errors");
    legend("ERK1", "ERK2", "ERK4")
    


%% Plot results

set(0, 'defaultAxesTickLabelInterpreter','latex'); set(0,'defaultLegendInterpreter','latex');

figure(1); clf;
    for i = 1:n_dt
       plot(T{i}, X.erk1{i}, 'DisplayName', "$dt=" +string(dt(i))+"$");
       hold on;
    end
       plot(T{1}, x0*exp(lambda*T{1}), 'DisplayName', 'True trajectory');
       title('ERK1');
       xlabel("$t$", 'Interpreter', 'latex', 'fontsize', 14);
       ylabel("$x(t)$", 'Interpreter', 'latex', 'fontsize', 14);
       legend('fontsize', 12, 'location', 'best');

    
figure(2); clf;
    for i = 1:n_dt
       plot(T{i}, X.erk2{i}, 'DisplayName', "$dt=" +string(dt(i))+"$");
       hold on;
    end
       plot(T{1}, x0*exp(lambda*T{1}), 'DisplayName', 'True trajectory');
       title('ERK2');
       xlabel("$t$", 'Interpreter', 'latex', 'fontsize', 14);
       ylabel("$x(t)$", 'Interpreter', 'latex', 'fontsize', 14);
       legend('fontsize', 12, 'location', 'best');
    
figure(3); clf;
    for i = 1:n_dt
       plot(T{i}, X.erk4{i}, 'DisplayName', "$dt=" +string(dt(i))+"$");
       hold on;
    end
       plot(T{1}, x0*exp(lambda*T{1}), 'DisplayName', 'True trajectory');
       title('ERK4');
       xlabel("$t$", 'Interpreter', 'latex', 'fontsize', 14);
       ylabel("$x(t)$", 'Interpreter', 'latex', 'fontsize', 14);
       legend('fontsize', 12, 'location', 'best');



function e = computeError(x_sim, x_true)

    e = abs(x_sim - x_true);

end






    
