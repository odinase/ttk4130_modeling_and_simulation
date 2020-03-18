function [ state_dot] = vanderpol( t, state, input )

x = state(1);
y = state(2);
u = input;

x_dot = y;
y_dot = u*(1-x^2)*y-x;

state_dot = [x_dot; y_dot];

end