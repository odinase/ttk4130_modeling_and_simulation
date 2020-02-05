function [ state_dot ] = SatelliteDynamics( t, x, parameters )

    % Code your equations here...

    % The code must return in the order you selected, e.g.:
    %    state_dot =  [velocity;
    %                  orientation_dot;
    %                  acceleration (ac);
    %                  angular acceleration (omega dot)];
    %    state     =  [position; 1:3
    %                  orientation; 4:7
    %                  velocity; 8:10
    %                  angular velocity]; 11:13
    p_dot = x(8:10);
    q_dot = 0.5 * quatProd(x(4:7), x(11:13));
    v_dot = -parameters.K / norm(x(1:3))^2 * (x(1:3) / norm(x(1:3)));
    w_dot = zeros(3, 1);
    
    state_dot = [p_dot;
                 q_dot;
                 v_dot;
                 w_dot];

end