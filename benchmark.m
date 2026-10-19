function [func, lb, ub, f_true, name] = benchmark(pn, n_dim, app)
    % BENCHMARK Global optimization test functions library
    %   [func, lb, ub, f_true, name] = benchmark(pn, n_dim, app)
    %   Provides 41 continuous and sequential test functions.

    if nargin < 2
        n_dim = 2; % Default dimension
    end
    if nargin < 3
        app = []; % Optional app handle for external function calls
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
            func = @(x) app.Shubert_func(x); 
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
            func = @(x) app.Ackley_func(x, n_dim); 
            lb = -15; ub = 15; f_true = 0;
            
        case 19
            name = sprintf('Rastrigin (%dD)', n_dim);
            func = @(x) 10*n_dim + sum(x.^2 - 10*cos(2*pi*x));
            lb = -5.12; ub = 5.12; f_true = 0;
            
        case 20
            name = sprintf('Sine-Squared (%dD)', n_dim);
            func = @(x) app.SineSquared_func(x, n_dim); 
            lb = -10; ub = 10; f_true = 0;
            
        case 21
            if n_dim ~= 3, error('Error (pn=21): Dimension must be 3.'); end
            func = @(x) app.Hartman3_func(x); 
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
            func = @(x) app.Perm_func(x, n, b); 
            lb = -4; ub = 4; f_true = 0;
            
        case 24
            if n_dim ~= 4, error('Error (pn=24): Dimension must be 4.'); end
            name = 'Power Sum (4D)';
            b = [8, 18, 44, 114];
            func = @(x) app.PowerSum_func(x, n, b); 
            lb = 0; ub = 4; f_true = 0;
            
        case 25
            if n_dim ~= 4, error('Error (pn=25): Dimension must be 4.'); end
            m = 5; f_true = -10.1532; name = 'Shekel (m=5)';
            func = @(x) app.Shekel_func(x, m); 
            lb = 0; ub = 10; 
            
        case 26
            if n_dim ~= 4, error('Error (pn=26): Dimension must be 4.'); end
            m = 7; f_true = -10.4029; name = 'Shekel (m=7)';
            func = @(x) app.Shekel_func(x, m); 
            lb = 0; ub = 10; 
            
        case 27
            if n_dim ~= 4, error('Error (pn=27): Dimension must be 4.'); end
            m = 10; f_true = -10.5364; name = 'Shekel (m=10)';
            func = @(x) app.Shekel_func(x, m); 
            lb = 0; ub = 10; 
            
        case 28
            if n_dim ~= 6, error('Error (pn=28): Dimension must be 6.'); end
            func = @(x) app.Hartman6_func(x); 
            lb = 0; ub = 1; f_true = -3.322368; name = 'Hartman 6';
            
        case 29
            name = sprintf('Griewank (%dD)', n_dim);
            func = @(x) app.Griewank_func(x, n_dim); 
            lb = -600; ub = 600; f_true = 0;
            
        case 30
            if n_dim ~= 10, error('Error (pn=30): Dimension must be 10.'); end
            func = @(x) sum((x - 1).^2) - sum(x(2:n) .* x(1:n-1));
            lb = -100; ub = 100; f_true = -200; name = 'Trid (10D)';
            
        case 31
            if mod(n_dim, 4) ~= 0, error('Error (pn=31): Dimension must be a multiple of 4.'); end
            func = @(x) app.Powell_func(x, n); 
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
            func = @(x) app.Ackley_func(x, n_dim); 
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
