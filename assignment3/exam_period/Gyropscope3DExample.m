clear all
clc

L = 2;   % Length of the gyropscope
omega = [0;0;4];  % Omega

r = random('norm',0,1,[3,1]);
R = expm([   0,      -r(3),  +r(2);
             +r(3),     0,   -r(1);
             -r(2), +r(1),    0]);      % Rotation matrix describing the Gyropscope orientation

p = R*[0;0;L];    % Position of the gyropscope centre
v = [0; 0; 0];

% Build quaternion from random angle-axis
th = norm(r);
k = r / th;
q = [cos(th / 2); k*sin(th / 2)];

% Initial angular velocity in body frame
w = [0; 0; 60*pi];

% g in inertia frame
params.g = [0; 0; -9.81];

% Radius of disc
R = 1;

% Mass of disc
m = 1;

% Mass of spinner
params.m = m;

% Inertia matrix about centre of mass
Mc = m*R^2/4*[1, 0, 0;
              0, 1, 0;
              0, 0, 2];

% End of rod in body frame
r = L*[0; 0; 1];

% Parallel axes theorem
Mo = Mc + m*(r'*r*eye(3) - r*r');
params.Mo = Mo;
params.r = r;

state = [q; w];

time_final = 30;

% Simulate satellite dynamics
[time,statetraj] = ode45(@(t,x)SpinnerDynamics(t, x, params),[0,time_final],state);

% Here below is a template for a real-time animation
tic; % resets Matlab clock
time_display = 0; % time displayed
while time_display < time(end)
    time_animate = toc; % get the current clock time
    % Interpolate the simulation at the current clock time
    state_animate = interp1(time,statetraj,time_animate);

    figure(1);clf;hold on
    % Use the example from "Satellite3DExample.m" to display your satellite

    q = reshape(state_animate(1:4), [], 1);
    w = reshape(state_animate(5:7), [], 1);
    
    R = quat2rotmat(q);
    
    p = R*r;   % Position of the satellite
    w = R*w;
    
    ScaleFrame = 2;   % Scaling factor for adjusting the frame size (cosmetic)
    FS         = 15;  % Fontsize for text
    SW         = 0.02; % Arrows size

    figure(1);clf;hold on
    MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
    MakeFrame(p,R,ScaleFrame,FS,SW,'b', 'color', 'b')
    Cylinder(zeros(3,1),p,0.1, 'color', [.5,0,.1]);
    MakeArrow(p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
    Cylinder(p,p+R*[0;0;0.25],1,'FaceColor','r','facealpha',0.25,'FaceLighting','gouraud','SpecularStrength',1,'Diffusestrength',0.5,'AmbientStrength',0.7,'SpecularExponent',5);
    FormatPicture([0;0;2],0.25*[73.8380   21.0967   30.1493])
    
    
    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; % get the current clock time
end




function xd = SpinnerDynamics(~,x,params)
    % x:
    % q:  Attitude of body frame, expressed as quaternion
    % w:  Angular velocity of body frame relative inertial frame in inertial frame
    % params:
    % m:  Mass of spinner
    % Mo: Inertia matrix about origin
    % r:  Arm of disc in body frame
    % g:  Gravity in inertial frame
    
    q = x(1:4);
    w = x(5:7);
    
    g = params.g;
    Mo = params.Mo;
    m = params.m;
    r = params.r;
    
    R = quat2rotmat(q);
    gb = R'*g;
    
    T = crossProdMat(r)*m*gb;
    % T = M*wd + w x (M*w) => wd = M \ (T - w x (M*w))
    wd = Mo \ (T - crossProdMat(w)*Mo*w);
    qd = 0.5 * quatProd(q, w);
    
    xd = [qd; wd];
    

end