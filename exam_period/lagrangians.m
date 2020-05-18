clear
clc

% Parameters
syms m g L real

% Variables
syms x1 x2 y1 y2 z1 z2 real
syms dx1 dx2 dy1 dy2 dz1 dz2 real

p1 = [x1; y1; z1];
p2 = [x2; y2; z2];
dp1 = [dx1; dy1; dz1];
dp2 = [dx2; dy2; dz2];

% Define symbolic variable q for the generalized coordinates
% x, theta1 and theta2

q = [p1; p2];o
q, 

% Define symbolic variable dq for the derivatives 
% of the generalized coordinates
dq = [dp1; dp2];
      
% Kinetic energy of the cart
T = 0.5 * m * (dp1')*dp1 + 0.5 * m * (dp2')*dp2;

T = simplify(T);

% Potential energy of the cart
V = m*g*p1(3) + m*g*p2(3);

V = simplify(V);

% Generalized forces
Q = [0; 0; 0];

% Constraints
nc = 3;

z = sym('z%d', [nc, 1], 'real');

% The balls must be exactly L apart
c1 = 0.5 * (((p1 - p2)')*(p1 - p2) - L.^2);

% Ball 1 must be on surface
c2 = p1(3) - (0.5 * p1(1).^2 + 0.5 * p1(2).^2);

% Ball 2 must be on surface
c3 = p2(3) - (0.5 * p2(1).^2 + 0.5 * p2(2).^2);

% Make vector of constraints
C = [c1; c2; c3];

% Lagrangian
Lag = T - V; % - (z')*C;

Lag_q = simplify(jacobian(Lag,q)).';
Lag_qdq = simplify(jacobian(Lag_q.',dq));
Lag_dq = simplify(jacobian(Lag,dq)).';
Lag_dqq = simplify(jacobian(Lag_dq,q)).';
Lag_dqdq = simplify(jacobian(Lag_dq.',dq));
ddt_Lag_dq = simplify(Lag_dqq*dq);

% fprintf('Lag_q\n')
disp(['Lag_q', ' = ', latex(Lag_q)])
fprintf('Lag_qdq\n')
latex(Lag_qdq)
fprintf('Lag_dqq\n')
latex(Lag_dqq)
fprintf('Lag_dq')
latex(Lag_dq)
fprintf('Lag_dqdq')
latex(Lag_dqdq)
fprintf('ddt_Lag_dq')
latex(ddt_Lag_dq)


% % The equations have the form W*q_dotdot = RHS, with
% W = Lag_dqdq;
% RHS = Q + simplify(Lag_q - Lag_qdq*dq);
% 
% state = [q;dq];
% param = [m;M;L;g];

% matlabFunction(p{1},p{2}, 'file','PendulumPosition','vars',{state, param});
% matlabFunction(W,RHS, 'file','PendulumODEMatrices','vars',{state,F,param});
%% 
%