function [ state_dot ] = SatelliteDynamics( t, x, parameters )

    % state
    % p: position of satellite in inertial frame
    % v: velocity of satellite in inertial frame
    % w: angular velocity of satellite in body frame
    % q: attitude as quaternion
    
    p = x(1:3);
    v = x(4:6);
    q = x(7:10);
    q = q / norm(q);
    w = x(11:13);
        
    % Gravitational constant
    G = parameters.G;

    % mass Terra(?), mass of Earth
    mT = parameters.mT;

    % mass satellite
    m = parameters.m;
    
    % Inertial matrix about centre of mass
    M = parameters.M;
    
    % Force from gravity in inertial frame as p is in inertial frame
    F = -(G*mT*m / norm(p)^2) * (p / norm(p));
    
    % Pure translative acceleration of point, translative as only force that passes through
    % centre of mass
    ag = F / m;
%     if t > 5
%        ag = ag*0; 
%     end
%     fprintf('ag: %d\nt: %d', ag, t);
    R = quat2rotmat(q);
    
    w_inertial = R*w;
    wX_inertial = crossProdMat(w_inertial);
    wX_body = crossProdMat(w);
    
    wd = -M \ (wX_body*M*w);
    pd = v;
    vd = wX_inertial^2*p + crossProdMat(R*wd)*p;
    qd = 0.5 * quatProd(q, w);
    state_dot = [pd; vd; qd; wd];
    

end
