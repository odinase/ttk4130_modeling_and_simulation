clear all
close all
clc

%%% FILL IN ALL PLACES LABELLED "complete"

syms rho theta psi real
syms drho dtheta dpsi real

A     = [rho;theta;psi];
dA    = [drho;dtheta;dpsi];

% rotation about x
R{1} = [cos(psi), -sin(psi), 0;
        sin(psi),  cos(psi), 0;
               0,         0, 1;];

% rotation about y
R{2} = [cos(theta), 0, sin(theta);
                 0, 1,          0;
       -sin(theta), 0, cos(theta)];

% rotation about z
R{3} = [1,        0,         0;
        0, cos(rho), -sin(rho);
        0, sin(rho),  cos(rho)];

%Rotation matrix
Rba = R{3}*R{2}*R{1};

%Time deriviatve of the rotation matrix (Hint: use
%the function "diff" to differentiate the matrix w.r.t. the angles
%rho, theta, psi one by one, and form the whole time derivative using the chain rule and summing the deriviatives)
dRba = diff(Rba, rho)*drho + diff(Rba, theta)*dtheta + diff(Rba, psi)*dpsi;

% Use the formulat relating Rba, dRba and Omega (skew-symmetric matrix underlying the angular velocity omega)
Omega = Rba'*dRba;

% Extract the angular veloticy vector omega (3x1) from the matrix Omega (3x3)
omega = [Omega(3, 2);
         Omega(1, 3);
         Omega(2, 1)];

% This line generates matrix M in the relationship omega = M*dA
M = jacobian(omega,dA);

% This line creates a Matlab function returing Rba and M for a given A  = [rho;theta;psi], can be called using [Rba,M] = Rotations(state);
matlabFunction(Rba,M,'file','Rotations','vars',{A})
