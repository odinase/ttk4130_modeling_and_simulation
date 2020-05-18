clear all
%close all
clc

% Define your initial state, e.g. as:
% state = [position;
%          orientation;
%          velocity;
%          angular velocity];

R_earth = 6356e3; % m
R_orbit = 36e6; % m

G = 6.67408e-11; % m^3 kg^-1 s^-2

mT = 5.972e24; % kg

rho = 1; % kg/m^3
l = 50e-2; % m
Vol = l^3;

m = rho*Vol;

I = 1/6*m*l^2*eye(3);

T = 2; % s

Vel_0 = 2*pi*R_orbit / T;
W0 = Vel_0 / R_orbit;

R = eye(3);

p0 = [0; R_orbit; 0];
v0 = [0; 0; Vel_0];
q0 = [1; 0; 0; 0];
w0 = [W0; 0; 0];

r0 = reshape(R, [], 1);

state = [p0; v0; q0; w0];

% Gravitational constant
parameters.G = G;

% mass Terra(?), mass of Earth
parameters.mT = mT;

% mass satellite
parameters.m = m;

% Add point mass
m0 = 0.1;
parameters.m = m + m0;

% Inertial matrix. Needs to account for additional mass

% Get arm to new CoG. Place in random corner
r2 = l/2 * randi(2, [3, 1]) - 1;
r_cm = m0 / (m + m0) * r2;

% Distance from CoG to each mass' own axis
d1 = -r_cm;
d2 = r2 - r_cm;

% Cube's inertia about own CoG
M1_bo = 1/6*m*l^2*eye(3);

% Parallel axes theorem
M1_bc = M1_bo + m*(d1'*d1*eye(3) - d1*d1');

% Inertia of point mass
M2_bc = m0*(d2'*d2*eye(3) - d2*d2');

% The total inertia is just a simple sum
parameters.M = M1_bc + M2_bc;

% "parameters" allows you to pass some parameters to the "SatelliteDynamics" function

time_final = 120; %Final time

% Simulate satellite dynamics
[time,statetraj] = ode45(@(t,x)SatelliteDynamics(t, x, parameters),[0,time_final],state);

% Here below is a template for a real-time animation
tic; % resets Matlab clock
time_display = 0; % time displayed
while time_display < time(end)
    time_animate = toc; % get the current clock time
    % Interpolate the simulation at the current clock time
    state_animate = interp1(time,statetraj,time_animate);

    figure(1);clf;hold on
    % Use the example from "Satellite3DExample.m" to display your satellite
    
    R = quat2rotmat(state_animate(7:10) / norm(state_animate(7:10)));
    
    p = reshape(state_animate(1:3), 3, [])*1e-7;   % Position of the satellite
    omega = R*reshape(state_animate(11:13), 3, []);  % Omega



    ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
    FS         = 15;  % Fontsize for text
    SW         = 0.035; % Arrows size

    figure(1);clf;hold on
    MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
    MakeFrame(p,R,ScaleFrame,FS,SW,'b', 'color', 'r')
    MakeArrow(p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
    DrawRectangle(p,R ,'color',[0.5,0.5,0.5]);
    FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])
    
    
    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; % get the current clock time
end
