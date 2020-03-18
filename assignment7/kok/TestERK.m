clear
clc
% Mass-damper-spring parameters
m = 1;
d = 0.1;
k = 1;
A = [ 0      1;
    -k/m -d/m];
% Mass-damper-spring vector field
fMassDamperSpring = @(t,x) A*x;

% Explicit Euler (RK1)
A1 = 0;
c1 = 0;
b1 = 1;
RK1 = struct('A',A1,'b',b1,'c',c1);

% Runge-Kutta 2 (RK2)
A2 = [0  0; 1/2 0];
c2 = [0; 1/2];
b2 = [0; 1];
RK2 = struct('A',A2,'b',b2,'c',c2);

% Heun's third-order method
A3 = [0  0  0; 1/3 0  0; 0  2/3 0];
c3 = sum(A3,2);
b3 = [1/4; 0; 3/4];
RK3 = struct('A',A3,'b',b3,'c',c3);
RK_mass = struct('A',A2,'b',b2,'c',c2);

% Runge-Kutta 4 (RK4)
A4 = [0 0 0 0; 1/2 0 0 0; 0 1/2 0 0; 0 0 1 0];
c4 = [0; 1/2; 1/2; 1];
b4 = [1/6; 1/3; 1/3; 1/6];
RK4 = struct('A',A4,'b',b4,'c',c4);

% Simulation parameters
lambda = -6.963;
dt = 0.163;
T = 0:dt:25;
x0 = 1;
func = @(t,x) lambda*x;
actual_solution = exp(lambda*T);

%exc3 params
u = 5;
state0 = [2;0];
t_final = 25;

% Simulate
X1 = ERKTemplate(RK1,func,T,dt,x0);
X2 = ERKTemplate(RK2,func,T,dt,x0);
X3 = ERKTemplate(RK3,func,T,dt,x0);
X4 = ERKTemplate(RK4,func,T,dt,x0);
X_mass = ERKTemplate(RK_mass,fMassDamperSpring,T,dt,[1;1]);

% simulate vanderpol
[time,statetraj] = ode45(@(t,x)vanderpol(t, x, u),[0 t_final], state0);
vanderpol_func = @(t,x) vanderpol(t, x, u);
X_vanderpol = ERKTemplate(RK4,vanderpol_func,T,dt,state0);


% Plot exc 2
%mass damper spring
% figure(1)
% plot(T,X_mass(1,:),T,X_mass(2,:)); legend('Position [m]','Velocity [m]');
% xlabel('Time [s]')
% grid on

%RK1-RK4
% figure(2)
% subplot(2,2,1)
% plot(T,X1,T,actual_solution); legend('RK1','Actual solution');
% ylabel('x(t)'); xlabel('Time [s]'); title('RK1');
% grid on
% 
% subplot(2,2,2)
% plot(T,X2,T,actual_solution); legend('RK2','Actual solution');
% xlabel('Time [s]'); title('RK2');
% grid on
% 
% subplot(2,2,3)
% plot(T,X3,T,actual_solution); legend('RK3','Actual solution');
% ylabel('x(t)'); xlabel('Time [s]'); title('RK3');
% grid on
% 
% subplot(2,2,4)
% plot(T,X4,T,actual_solution); legend('RK4','Actual solution');
% xlabel('Time [s]'); title('RK4');
% grid on


% Plot exc 3
%vanderpol
figure(3)
subplot(2,1,1)
plot(time,statetraj(:,1),T,X_vanderpol(1,:));
ylabel('x(t)'); legend('ODE45', 'RK4');
grid on

subplot(2,1,2)
plot(time,statetraj(:,2),T,X_vanderpol(2,:));
ylabel('y(t)'); xlabel('Time [s]'); legend('ODE45', 'RK4');
grid on