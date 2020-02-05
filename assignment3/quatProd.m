function q = quatProd(ql, qr)

    if length(ql) == 3
        ql = [0; ql];
    end
    
    if length(qr) == 3
        qr = [0; qr];
    end
    
    if length(ql) ~= 4 || length(qr) ~= 4
        error('Quaternions are not of length 4!');
    end
    
    q = [ql(1)*qr(1) - ql(2:end)'*qr(2:end);
        qr(1)*ql(2:end) + ql(1)*qr(2:end) + cross(ql(2:end), qr(2:end))];

end

