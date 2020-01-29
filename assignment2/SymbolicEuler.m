clear all
close all
clc

%%% FILL IN ALL PLACES LABELLED "complete"

syms rho theta psi real
syms drho dtheta dpsi real

A     = [rho;theta;psi];
dA    = [drho;dtheta;dpsi];

% rotation about x
R{1} = [complete];

% rotation about y
R{2} = [complete];

% rotation about z
R{3} = [complete];

%Rotation matrix
Rba = simple(complete);

%Time deriviatve of the rotation matrix (Hint: use
%the function "diff" to differentiate the matrix w.r.t. the angles
%rho, theta, psi one by one, and form the whole time derivative using the chain rule and summing the deriviatives)
dRba = complete;

% Use the formulat relating Rba, dRba and Omega (skew-symmetric matrix underlying the angular velocity omega)
Omega = complete;

% Extract the angular veloticy vector omega (3x1) from the matrix Omega (3x3)
omega = complete;

% This line generates matrix M in the relationship omega = M*dA
M = jacobian(omega,dA)

% This line creates a Matlab function returing Rba and M for a given A  = [rho;theta;psi], can be called using [Rba,M] = Rotations(state);
matlabFunction(Rba,M,'file','Rotations','vars',{A})
