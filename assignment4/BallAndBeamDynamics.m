function state_dot = BallAndBeamDynamics(state, parameters)

    q = state(1:2);
    q_dot = state(3:4);
    T = 200*(q(1) - q(2)) + 70*(q_dot(1) - q_dot(2));
    [W, RHS] = BallAndBeamODEMatrices(state, T, parameters);
    
    state_dot = [q_dot; W\RHS];


end

