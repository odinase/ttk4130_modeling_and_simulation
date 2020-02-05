clear all
%close all
clc

% Define your initial state, e.g. as:
% state = [position;
%          orientation;
%          velocity;
%          angular velocity];

% "parameters" allows you to pass some parameters to the "SatelliteDynamics" function

time_final = 120; %Final time

% Simulate satellite dynamics
[time,statetraj] = ode45(@(t,x)SateliteDynamics(t, x, parameters),[0,time_final],state);

% Here below is a template for a real-time animation
tic; % resets Matlab clock
time_display = 0; % time displayed
while time_display < time(end)
    time_animate = toc; % get the current clock time
    % Interpolate the simulation at the current clock time
    state_animate = interp1(time,statetraj,time_animate);

    figure(1);clf;hold on
    % Use the example from "Satellite3DExample.m" to display your satellite

    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; % get the current clock time
end
