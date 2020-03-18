function x = ERKTemplate(ButcherArray, f, T, ~, x0)
    % Returns the iterations of an ERK method
    % ButcherArray: Struct with the ERK's Butcher array
    % f: Function handle
    %    Vector field of ODE, i.e., x_dot = f(t,x)
    % T: Vector of time points, 1 x Nt
    % x0: Initial state, Nx x 1
    % x: ERK iterations, Nx x Nt
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Define variables
    % Allocate space for iterations (x) and k1,k2,...,kNstage
    % It is recommended to allocate a matrix K for all kj, i.e.
    % K = [k1 k2 ... kNstage]
    Nx = length(x0);
    Nt = length(T);
    x = zeros(Nx, Nt);
    Nstage = length(ButcherArray.b);
    A = ButcherArray.A;
    b = ButcherArray.b;
    c = ButcherArray.c;   
    K = zeros(Nstage*Nx, 1);
    sum_aK = @(s) kron(A(s,:), eye(Nx))*K;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x(:, 1) = x0; % initial iteration
    % Loop over time points
    for nt=2:Nt
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Update variables
        K = zeros(Nstage*Nx, 1);
        tk = T(nt - 1);
        k = nt - 1;
        kp1 = nt;
        xk = x(:, k);
        dt = T(nt) - T(nt - 1);
        sum_aK_t = sum_aK(1);
        kron(A(1,:), eye(Nx));
        K(1:Nx) = f(tk, xk);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Loop that calculates k1,k2,...,kNstage
        for nstage=2:Nstage
            sum_aK_t = sum_aK(nstage);
            l = kron(A(nstage,:), eye(Nx));
            K(((nstage-1)*Nx+1):nstage*Nx) = ...
                f(tk, xk + dt*sum_aK(nstage));
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Calculate and save next iteration value x_t
        
        x(:, kp1) = xk + dt*kron(b, eye(Nx))'*K;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end