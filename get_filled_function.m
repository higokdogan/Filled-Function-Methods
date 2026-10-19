function P = get_filled_function(ff_id, f, params)
    % GET_FILLED_FUNCTION Generates the handle for the selected Filled Function
    %   P = get_filled_function(ff_id, f) returns the function handle P(x, xk, fk)
    %   for the filled function specified by ff_id ('P1' to 'P6').
    
    % Default parameters if not provided
    if nargin < 3
        params.a = 1;
        params.rho = 5;
        params.r = 10;
        params.gamma = 1;
        params.theta = 0.05;
        params.eps = 1e-4;
    end

    switch ff_id
        case 'P1' % Ge & Qin (1987)
            P = @(x, xk, fk) -(params.rho^2 * log(params.r + f(x)) + norm(x - xk)^2);
            
        case 'P2' % Ge (1990)
            P = @(x, xk, fk) -(f(x) - fk) * exp(params.gamma * norm(x - xk)^2);
            
        case 'P3' % Liu (2002)
            P = @(x, xk, fk) 1 / log(1 + abs(f(x) - fk) + 1e-5) - params.gamma * norm(x - xk)^2;
            
        case 'P4' % Sahiner et al. (2025)
            P = @(x, xk, fk) real(exp(-norm(x - xk)^2) - params.a * (min(f(x) - fk, 0))^2);
            
        case 'P5' % Wang et al. (2012)
            P = @(x, xk, fk) 1 / (1 + norm(x - xk)^2) - atan((min(0, f(x) - fk))^2);
            
        case 'P6' % Yilmaz (2025)
            phi1 = @(t) (t <= -params.eps).*t + ...
                        (t > -params.eps & t < 0).*(-(1/params.eps^2)*t.^3 - (2/params.eps)*t.^2) + ...
                        (t >= 0).*0;
            phi2 = @(dz) (dz >= params.eps).*dz + ...
                         (dz > -params.eps & dz < params.eps).*((dz.^2)/(2*params.eps) + params.eps/2) + ...
                         (dz <= -params.eps).*(-dz);
            P = @(x, xk, fk) phi1(f(x) - fk) - params.theta * phi2(norm(x - xk)) + fk;
            
        otherwise
            error('Error: Filled Function ID (%s) not found.', ff_id);
    end
end
