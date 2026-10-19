function [func, lb, ub, f_true, name] = benchmark(pn, n_dim)
    % BENCHMARK Global optimization test functions library
    %   [func, lb, ub, f_true, name] = benchmark(pn, n_dim)
    %   Provides 41 continuous, standalone, and sequential test functions.

    if nargin < 2
        n_dim = 2; % Default dimension
    end

    n = n_dim;

    switch pn
        case 1
            if n_dim ~= 2, error('Error (pn=1): Dimension must be 2.'); end
            c = 0.5;
            func = @(x) (1 - 2*x(2) + c*sin(4*pi*x(2)) - x(1))^2 + (x(2) - 0.5*sin(2*pi*x(1)))^2;
            lb = -10; ub = 10; f_true = 0; name = 'Test Func (c=0.5)';
            
        case 2
            if n_dim ~= 2, error('Error (pn=2): Dimension must be 2.'); end
            c = 0.2;
            func = @(x) (1 - 2*x(2) + c*sin(4*pi*x(2)) - x(1))^2 + (x(2) - 0.5*sin(2*pi*x(1)))^2;
            lb = -10; ub = 10; f_true = 0; name = 'Test Func (c=0.2)';
            
        case 3
            if n_dim ~= 2, error('Error (pn=3): Dimension must be 2.'); end
            c = 0.05;
            func = @(x) (1 - 2*x(2) + c*sin(4*pi*x(2)) - x(1))^2 + (x(2) - 0.5*sin(2*pi*x(1)))^2;
            lb = -10; ub = 10; f_true = 0; name = 'Test Func (c=0.05)';
            
        case 4
            if n_dim ~= 2, error('Error (pn=4): Dimension must be 2.'); end
            func = @(x) 2*x(1)^2 - 1.05*x(1)^4 + (1/6)*x(1)^6 - x(1)*x(2) + x(2)^2;
            lb = -3; ub = 3; f_true = 0; name = 'Three-Hump Camel';
            
        case 5
            if n_dim ~= 2, error('Error (pn=5): Dimension must be 2.'); end
            func = @(x) 4*x(1)^2 - 2.1*x(1)^4 + (1/3)*x(1)^6 - x(1)*x(2) - 4*x(2)^2 + 4*x(2)^4;
            lb = -3; ub = 3; f_true = -1.0316; name = 'Six-Hump Camel';
            
        case 6
            if n_dim ~= 2, error('Error (pn=6): Dimension must be 2.'); end
            func = @(x) x(1)^4 + 4*x(1)^3 + 4*x(1)^2 + x(2)^2;
            lb = -3; ub = 3; f_true = 0; name = 'Treccani';
            
        case 7
            if n_dim ~= 2, error('Error (pn=7): Dimension must be 2.'); end
            func = @(x) (1 + (x(1) + x(2) + 1)^2 * (19 - 14*x(1) + 3*x(1)^2 - 14*x(2) + 6*x(1)*x(2) + 3*x(2)^2)) * ...
                        (30 + (2*x(1) - 3*x(2))^2 * (18 - 32*x(1) + 12*x(1)^2 + 48*x(2) - 36*x(1)*x(2) + 27*x(2)^2));
            lb = -3; ub = 3; f_true = 3; name = 'Goldstein-Price';
            
        case 8
            if n_dim ~= 2, error('Error (pn=8): Dimension must be 2.'); end
            func = @(x) shubert_local(x); 
            lb = -10; ub = 10; f_true = -186.7309; name = 'Shubert I';
            
        case 9
            if n_dim ~= 2, error('Error (pn=9): Dimension must be 2.'); end
            func = @(x) x(1)^2 + x(2)^2 - cos(18*x(1)) - cos(18*x(2));
            lb = -10; ub = 10; f_true = -2; name = 'Rastrigin Variant';
            
        case 10
            if n_dim ~= 2, error('Error (pn=10): Dimension must be 2.'); end
            func = @(x) (1.5 - x(1)*(1-x(2)))^2 + (2.25 - x(1)*(1-x(2)^2))^2 + (2.625 - x(1)*(1-x(2)^3))^2;
            lb = -4.5; ub = 4.5; f_true = 0; name = 'Beale';
            
        case 11
            if n_dim ~= 2, error('Error (pn=11): Dimension must be 2.'); end
            func = @(x) x(1)^2 + 2*x(2)^2 - 0.3*cos(3*pi*x(1)) - 0.4*cos(4*pi*x(2)) + 0.7;
            lb = -100; ub = 100; f_true = 0; name = 'Bohachevsky 1';
            
        case 12
            if n_dim ~= 2, error('Error (pn=12): Dimension must be 2.'); end
            func = @(x) x(1)^2 + 2*x(2)^2 - 0.3*cos(3*pi*x(1))*cos(4*pi*x(2)) + 0.3;
            lb = -100; ub = 100; f_true = 0; name = 'Bohachevsky 2';
            
        case 13
            if n_dim ~= 2, error('Error (pn=13): Dimension must be 2.'); end
            func = @(x) x(1)^2 + 2*x(2)^2 - 0.3*cos(3*pi*x(1) + 4*pi*x(2)) + 0.3;
            lb = -100; ub = 100; f_true = 0; name = 'Bohachevsky 3';
            
        case 14
            if n_dim ~= 2, error('Error (pn=14): Dimension must be 2.'); end
            func = @(x) (x(1) + 2*x(2) - 7)^2 + (2*x(1) + x(2) - 5)^2;
            lb = -10; ub = 10; f_true = 0; name = 'Booth';
            
        case 15
            if n_dim ~= 2, error('Error (pn=15): Dimension must be 2.'); end
            func = @(x) (x(2) - (5.1/(4*pi^2))*x(1)^2 + 5*x(1)/pi - 6)^2 + 10*(1 - 1/(8*pi))*cos(x(1)) + 10;
            lb = 0; ub = 15; f_true = 0.397887; name = 'Branin';
            
        case 16
            if n_dim ~= 2, error('Error (pn=16): Dimension must be 2.'); end
            func = @(x) -cos(x(1))*cos(x(2))*exp(-(x(1)-pi)^2 - (x(2)-pi)^2);
            lb = -100; ub = 100; f_true = -1; name = 'Easom';
            
        case 17
            if n_dim ~= 2, error('Error (pn=17): Dimension must be 2.'); end
            func = @(x) 0.26*(x(1)^2 + x(2)^2) - 0.48*x(1)*x(2);
            lb = -10; ub = 10; f_true = 0; name = 'Matyas';
            
        case 18
            name = sprintf('Ackley (%dD)', n_dim);
            func = @(x) ackley_local(x, n_dim); 
            lb = -15; ub = 15; f_true = 0;
            
        case 19
            name = sprintf('Rastrigin (%dD)', n_dim);
            func = @(x) 10*n_dim + sum(x.^2 - 10*cos(2*pi*x));
            lb = -5.12; ub = 5.12; f_true = 0;
            
        case 20
            name = sprintf('Sine-Squared (%dD)', n_dim);
            func = @(x) sum(sin(x).^2); 
            lb = -10; ub = 10; f_true = 0;
            
        case 21
            if n_dim ~= 3, error('Error (pn=21): Dimension must be 3.'); end
            func = @(x) hartman3_local(x); 
            lb = 0; ub = 1; f_true = -3.86278; name = 'Hartman 3';
            
        case 22
            if n_dim ~= 4, error('Error (pn=22): Dimension must be 4.'); end
            func = @(x) 100*(x(1)^2 - x(2))^2 + (x(1) - 1)^2 + (x(3) - 1)^2 + 90*(x(3)^2 - x(4))^2 + ...
                        10.1*((x(2) - 1)^2 + (x(4) - 1)^2) + 19.8*(x(2) - 1)*(x(4) - 1);
            lb = -10; ub = 10; f_true = 0; name = 'Colville';
            
        case 23
            if n_dim ~= 4, error('Error (pn=23): Dimension must be 4.'); end
            name = 'Perm (4D)';
            b = 0.5;
            func = @(x) perm_local(x, n, b); 
            lb = -4; ub = 4; f_true = 0;
            
        case 24
            if n_dim ~= 4, error('Error (pn=24): Dimension must be 4.'); end
            name = 'Power Sum (4D)';
            b = [8, 18, 44, 114];
            func = @(x) powersum_local(x, n, b); 
            lb = 0; ub = 4; f_true = 0;
            
        case 25
            if n_dim ~= 4, error('Error (pn=25): Dimension must be 4.'); end
            m = 5; f_true = -10.1532; name = 'Shekel (m=5)';
            func = @(x) shekel_local(x, m); 
            lb = 0; ub = 10; 
            
        case 26
            if n_dim ~= 4, error('Error (pn=26): Dimension must be 4.'); end
            m = 7; f_true = -10.4029; name = 'Shekel (m=7)';
            func = @(x) shekel_local(x, m); 
            lb = 0; ub = 10; 
            
        case 27
            if n_dim ~= 4, error('Error (pn=27): Dimension must be 4.'); end
            m = 10; f_true = -10.5364; name = 'Shekel (m=10)';
            func = @(x) shekel_local(x, m); 
            lb = 0; ub = 10; 
            
        case 28
            if n_dim ~= 6, error('Error (pn=28): Dimension must be 6.'); end
            func = @(x) hartman6_local(x); 
            lb = 0; ub = 1; f_true = -3.322368; name = 'Hartman 6';
            
        case 29
            name = sprintf('Griewank (%dD)', n_dim);
            func = @(x) sum(x.^2)/4000 - prod(cos(x ./ sqrt(1:n_dim))) + 1; 
            lb = -600; ub = 600; f_true = 0;
            
        case 30
            if n_dim ~= 10, error('Error (pn=30): Dimension must be 10.'); end
            func = @(x) sum((x - 1).^2) - sum(x(2:n) .* x(1:n-1));
            lb = -100; ub = 100; f_true = -200; name = 'Trid (10D)';
            
        case 31
            if mod(n_dim, 4) ~= 0, error('Error (pn=31): Dimension must be a multiple of 4.'); end
            func = @(x) powell_local(x, n); 
            lb = -4; ub = 5; f_true = 0; name = sprintf('Powell (%dD)', n_dim);
            
        case 32
            name = sprintf('Dixon-Price (%dD)', n);
            katsayilar = (2:n); 
            func = @(x) (x(1) - 1)^2 + sum(katsayilar .* (2*x(2:n).^2 - x(1:n-1)).^2);
            lb = -10; ub = 10; f_true = 0; 
            
        case 33
            name = sprintf('Schwefel (%dD)', n_dim);
            func = @(x) 418.9829*n_dim - sum(x .* sin(sqrt(abs(x))));
            lb = -500; ub = 500; f_true = 0;
            
        case 34
            name = sprintf('Rosenbrock (%dD)', n_dim);
            func = @(x) sum(100*(x(1:n-1).^2 - x(2:n)).^2 + (x(1:n-1) - 1).^2);
            lb = -5; ub = 10; f_true = 0;
            
        case 35
            name = sprintf('Sphere (%dD)', n_dim);
            func = @(x) sum(x.^2);
            lb = -5.12; ub = 5.12; f_true = 0;
            
        case 36
            name = sprintf('Sum Squares (%dD)', n_dim);
            func = @(x) sum((1:n) .* (x.^2));
            lb = -10; ub = 10; f_true = 0;
            
        case 37
            name = sprintf('Zakharov (%dD)', n_dim);
            func = @(x) sum(x.^2) + (sum(0.5 * (1:n) .* x))^2 + (sum(0.5 * (1:n) .* x))^4;
            lb = -5; ub = 10; f_true = 0;
            
        case 38
            name = sprintf('Asym. Rastrigin (%dD)', n_dim);
            func = @(x) 10*n_dim + sum(x.^2 - 10*cos(2*pi*x));
            lb = -2.00; ub = 5.12; f_true = 0; 
            
        case 39
            name = sprintf('Asym. Ackley (%dD)', n_dim);
            func = @(x) ackley_local(x, n_dim); 
            lb = -10; ub = 15; f_true = 0;
            
        case 40
            name = sprintf('Asym. Rosenbrock (%dD)', n_dim);
            func = @(x) sum(100*(x(2:end) - x(1:end-1).^2).^2 + (1 - x(1:end-1)).^2);
            lb = -5; ub = 10; f_true = 0;
            
        case 41
            name = sprintf('Asym. Griewank (%dD)', n_dim);
            func = @(x) sum(x.^2)/4000 - prod(cos(x ./ sqrt(1:n_dim))) + 1;
            lb = -300; ub = 600; f_true = 0;
            
        otherwise
            error('Error: Problem ID %d not found.', pn);
    end
end

% =========================================================================
% LOCAL FUNCTIONS FOR COMPLEX BENCHMARKS
% =========================================================================

function f = shubert_local(x)
    sum1 = 0; sum2 = 0;
    for i = 1:5
        sum1 = sum1 + i * cos((i+1)*x(1) + i);
        sum2 = sum2 + i * cos((i+1)*x(2) + i);
    end
    f = sum1 * sum2;
end

function f = ackley_local(x, n_dim)
    f = -20 * exp(-0.2 * sqrt(sum(x.^2)/n_dim)) - exp(sum(cos(2*pi*x))/n_dim) + 20 + exp(1);
end

function f = hartman3_local(x)
    a = [3 10 30; 0.1 10 35; 3 10 30; 0.1 10 35];
    c = [1; 1.2; 3; 3.2];
    p = [0.3689 0.1170 0.2673; 0.4699 0.4387 0.7470; 0.1091 0.8732 0.5547; 0.0381 0.5743 0.8828];
    f = 0;
    for i = 1:4
        f = f - c(i) * exp(-sum(a(i,:) .* (x - p(i,:)).^2));
    end
end

function f = perm_local(x, n_dim, b)
    f = 0;
    for i = 1:n_dim
        sum_val = 0;
        for j = 1:n_dim
            sum_val = sum_val + (j^i + b) * ((x(j)/j)^i - 1);
        end
        f = f + sum_val^2;
    end
end

function f = powersum_local(x, n_dim, b)
    f = 0;
    for i = 1:n_dim
        sum_val = 0;
        for j = 1:n_dim
            sum_val = sum_val + x(j)^i;
        end
        f = f + (sum_val - b(i))^2;
    end
end

function f = shekel_local(x, m)
    a = [4 4 4 4; 1 1 1 1; 8 8 8 8; 6 6 6 6; 3 7 3 7; 
         2 9 2 9; 5 5 3 3; 8 1 8 1; 6 2 6 2; 7 3.6 7 3.6];
    c = [0.1; 0.2; 0.2; 0.4; 0.4; 0.6; 0.3; 0.7; 0.5; 0.5];
    f = 0;
    for i = 1:m
        f = f - 1 / (sum((x - a(i,:)).^2) + c(i));
    end
end

function f = hartman6_local(x)
    a = [10 3 17 3.5 1.7 8; 0.05 10 17 0.1 8 14; 
         3 3.5 1.7 10 17 8; 17 8 0.05 10 0.1 14];
    c = [1; 1.2; 3; 3.2];
    p = [0.1312 0.1696 0.5569 0.0124 0.8283 0.5886;
         0.2329 0.4135 0.8307 0.3736 0.1004 0.9991;
         0.2348 0.1451 0.3522 0.2883 0.3047 0.6650;
         0.4047 0.8828 0.8732 0.5743 0.1091 0.0381];
    f = 0;
    for i = 1:4
        f = f - c(i) * exp(-sum(a(i,:) .* (x - p(i,:)).^2));
    end
end

function f = powell_local(x, n_dim)
    f = 0;
    for i = 1:(n_dim/4)
        idx = 4*(i-1);
        x1 = x(idx+1); x2 = x(idx+2); x3 = x(idx+3); x4 = x(idx+4);
        f = f + (x1 + 10*x2)^2 + 5*(x3 - x4)^2 + (x2 - 2*x3)^4 + 10*(x1 - x4)^4;
    end
end
