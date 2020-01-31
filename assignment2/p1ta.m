R2 = sym('R', [3, 3], 'real');
r = R2(:);
r([1, 3, 5]) = []; % Don't solve for variables we don't have
R2(1, 1) = 5/13;
R2(2, 2) = 1;
R2(3, 1) = 12/13;
RTR = R2'*R2;
rtr = RTR(:);
rtr(end+1) = det(R2);
I = eye(3);
I = I(:);
I(end + 1) = 1;
rtr = rtr(5:end); % remove the four first equations
I = I(5:end); % remove the four first equations
S = solve(rtr == I, r);