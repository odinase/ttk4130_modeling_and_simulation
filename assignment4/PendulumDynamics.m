function state_dot = PendulumDynamics(state, parameters)
    
    q = state(1:3);
    q_dot = state(4:6);
    F = -10*q(1) - q_dot(1);
    [W, RHS] = PendulumODEMatrices(state, F, parameters);
    
    state_dot = [q_dot; W\RHS];

end

