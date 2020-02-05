function R = quat2rot(q)
    
    n = q(1);
    e = q(2:end);
    
    R = eye(3) + 2*n*skew(e) + 2*skew(e)*skew(e);

end

