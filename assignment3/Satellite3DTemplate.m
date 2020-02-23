clear all
%close all
clc

% "parameters" allows you to pass some parameters to the "SatelliteDynamics" function
% f = 1 / (3600 * 24); % 1 rotation per day
% r_earth = 6356e3; % m
% r_orbit = 36e6; % m
% M_earth = 5.972e24; % kg
% G = 6.67408e-11; % m^3 kg^-1 s^-2
% m_sat = 500; % kg. Source: https://en.wikipedia.org/wiki/Small_satellite
% l = 0.5; % m
f = 1 / 5; % 1 rotation per day
r_earth = 1; % m
r_orbit = 1; % m
M_earth = 1; % kg
G = 1; % m^3 kg^-1 s^-2
m_sat = 1; % kg. Source: https://en.wikipedia.org/wiki/Small_satellite
l = 1; % m
parameters.M = 1/6 * m_sat * l^2 * eye(3);
parameters.K = G*M_earth;
parameters.w = [0, 2*pi*f, 0]'; % The satellite pitches during rotation

% Define your initial state, e.g. as:
% state = [position;
%          orientation;
%          velocity;
%          angular velocity];
p0 = [0, 0, r_orbit]';
k = [0, 0, 1]';
alpha = pi/2;
q0 = [cos(alpha/2); sin(alpha/2)*k];
v0 = zeros(3, 1); %[2*pi*f*r_orbit, 0, 0]';
w0 = parameters.w;

state = [p0; q0; v0; w0];

time_final = 120; %Final time

% Simulate satellite dynamics
[time,statetraj] = ode45(@(t,x)SatelliteDynamics(t, x, parameters),[0,time_final],state);

% Here below is a template for a real-time animation
tic; % resets Matlab clock
time_display = 0; % time displayed
% while time_display < time(end)
%     time_animate = toc; % get the current clock time
%     % Interpolate the simulation at the current clock time
%     state_animate = interp1(time,statetraj,time_animate);
% 
%     figure(1);clf;hold on
%     % Use the example from "Satellite3DExample.m" to display your satellite
%     p = state_animate(1:3)';   % Position of the satellite
%     omega = state_animate(11:13)';  % Omega
%     q = state_animate(4:7)';
%     n = q(1);
%     e = q(2:end)';
%     
%     R = eye(3) + 2*n*skew(e) + 2*skew(e)^2;
%     
%     ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
%     FS         = 15;  % Fontsize for text
%     SW         = 0.035; % Arrows size
% 
%     MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
%     MakeFrame(p,R,ScaleFrame,FS,SW,'b', 'color', 'r')
%     MakeArrow(p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
%     DrawRectangle(p,R ,'color',[0.5,0.5,0.5]);
%     FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])
%     
%     
%     if time_display == 0
%         display('Hit a key to start animation')
%         pause
%         tic
%     end
%     time_display = toc; % get the current clock time
% end
