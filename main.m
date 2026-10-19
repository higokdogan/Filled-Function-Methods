% %% Filled Function Global Optimization - Main Algorithm
clear all; clc;

% --- 1. Problem Initialization ---
pn = 18;      
n_dim = 2;   
[f, lb, ub, f_true, func_name] = benchmark(pn, n_dim);

% --- 2. Filled Function Selection ---
ff_id = 'P5'; 
P = get_filled_function(ff_id, f);

% --- 3. Algorithm Parameters ---
x0 = lb + (ub - lb) .* rand(1, n_dim); 
max_iter = 50;   
step_size = 0.1; 

options = optimoptions('fminunc', 'Display', 'off', ...
    'Algorithm', 'quasi-newton', ...
    'StepTolerance', 1e-8, ...
    'OptimalityTolerance', 1e-8);

total_feval = 0;
basin_escapes = 0;

fprintf('========================================================\n');
fprintf(' FFM Global Optimization Benchmark Testing\n');
fprintf(' Target Function : %s\n', func_name);
fprintf(' Filled Function : %s\n', ff_id);
fprintf(' Global Optimum  : %.4f\n', f_true);
fprintf('========================================================\n');

t_start = tic; 

% --- 4. Phase 1: Initial Local Search ---
[xk_star, fk_star, ~, out_f] = fminunc(f, x0, options);
total_feval = total_feval + out_f.funcCount;
fprintf('Initial Trap: Local Min at f(x) = %8.4f | x1 = %.4f\n', fk_star, xk_star(1));

directions = [eye(n_dim); -eye(n_dim)] * step_size;

% --- 5. Phase 2: Core Global Search Loop ---
for iter = 1:max_iter
    found_better = false;
    
    for d = 1:size(directions, 1)
        x_start_P = xk_star + directions(d, :); 
        
        obj_P = @(x) P(x, xk_star, fk_star);
        [x_fill, ~, ~, out_p] = fminunc(obj_P, x_start_P, options);
        total_feval = total_feval + out_p.funcCount; 
        
        if f(x_fill) < fk_star
            [x_new_star, f_new_star, ~, out_f2] = fminunc(f, x_fill, options);
            total_feval = total_feval + out_f2.funcCount;
            
            if f_new_star < fk_star
                basin_escapes = basin_escapes + 1;
                fprintf('Escape %d    : New Min at   f(x) = %8.4f | x1 = %.4f\n', ...
                        basin_escapes, f_new_star, x_new_star(1));
                
                xk_star = x_new_star;
                fk_star = f_new_star;
                found_better = true;
                break; 
            end
        end
    end
    
    if ~found_better
        break;
    end
end

total_time = toc(t_start); 

% --- 6. Results Summary ---
fprintf('--------------------------------------------------------\n');
fprintf(' Optimization Terminated. Global Minimum Assumed.\n');
fprintf('--------------------------------------------------------\n');
fprintf(' Final Global Minimum : f(x) = %.6f\n', fk_star);
fprintf(' Total Basin Escapes  : %d iterations\n', basin_escapes);
fprintf(' Total Fevals         : %d evaluations\n', total_feval);
fprintf(' Total CPU Time       : %.4f seconds\n', total_time);
fprintf('========================================================\n');
