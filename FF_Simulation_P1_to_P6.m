% %% Modular Filled Function Comparison Simulation
clear all; clc; close all;

% --- 1. Parameters and Test Function ---
a = [7, 3, 5, 9]; 
b = [-5, 0, 3, 12]; 

% Objective Function f(x)
f = @(x) 4 - (a(1)./(1+(x-b(1)).^2) + a(2)./(1+(x-b(2)).^2) + ...
              a(3)./(1+(x-b(3)).^2) + a(4)./(1+(x-b(4)).^2));
x = linspace(-12, 16, 1000);
fx = f(x);

% --- 2. PLOT OBJECTIVE FUNCTION IN A SEPARATE WINDOW ---
fig_obj = figure('Name', 'Objective Function Landscape', 'Color', 'w', 'Position', [50, 200, 600, 400]);
plot(x, fx, 'Color', [0 0.4470 0.7410], 'LineWidth', 2.2, 'DisplayName', '$f(x)$');
hold on; grid on; box on;
[f_min, idx] = min(fx);
plot(x(idx), f_min, 'p', 'MarkerFaceColor', '#D95319', 'MarkerEdgeColor', 'k', ...
     'MarkerSize', 12, 'DisplayName', 'Global Optimum');
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$f(x)$', 'Interpreter', 'latex', 'FontSize', 12);
title('\textbf{Graph of the Objective Function} $f(x)$', 'Interpreter', 'latex', 'FontSize', 14);
legend('Location', 'best', 'Interpreter', 'latex', 'FontSize', 11);
ylim([-6, 6]); xlim([-12, 16]);
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 11, 'LineWidth', 1);

% --- 3. Definitions of the Auxiliary/Filled Functions (P1 - P6) ---
% IMPORTANT NOTE ON PARAMETER TUNING:
% For the code to run properly and demonstrate the filled function correctly 
% on different objective functions, the parameters (rho, r, gamma, a, theta, eps_val) 
% must be carefully tuned. Improper parameters may lead to false local maxima 
% or numerical overflow. Parameter-free methods (P5) do not require this step.

% Options: 'P1', 'P2', 'P3', 'P4', 'P5', 'P6'
selected_FF = 'P6'; 

switch selected_FF
    case 'P1'
        % P1: Ge & Qin (1987) Logarithmic
        % Equation: P1 = -(rho^2 * ln[r+f(x)] + ||x-xk||^2)
        rho = 5; r = 10; 
        % Note: Scaled (*0.2) and offset by fk for visual alignment in the plot
        ff_func = @(x, xk, fk) (-(rho^2 * log(r + f(x)) + (x - xk).^2) + (rho^2 * log(r + fk))) * 0.2;
        tit_str = 'P_1: Ge & Qin (1987) Logarithmic';
        
    case 'P2'
        % P2: Ge (1990) Exponential
        % Equation: P2 = -[f(x)-f(xk)] * exp(gamma * ||x-xk||^2)
        gamma = 0.5; 
        ff_func = @(x, xk, fk) -(f(x) - fk) .* exp(gamma * (x - xk).^2);
        tit_str = 'P_2: Ge (1990) Exponential';
        
    case 'P3'
        % P3: Liu (2002) Discontinuous
        % Equation: P3 = 1 / ln[1+f(x)-f(xk)] - gamma * ||x-xk||^2
        gamma = 1;
        % Note: abs() and +1e-5 added strictly to prevent MATLAB domain errors (complex numbers/div-by-zero)
        ff_func = @(x, xk, fk) 1 ./ log(1 + abs(f(x) - fk) + 1e-5) - gamma * (x - xk).^2;
        tit_str = 'P_3: Liu (2002) Discontinuous';
        
    case 'P4'
        % P4: Sahiner et al. (2025) One-Parameter Bounded
        % Equation: P4 = exp(-||x-xk||^2) - a*[min(f(x)-f(xk),0)]^2
        param_a = 1;
        ff_func = @(x, xk, fk) exp(-(x - xk).^2) - param_a * (min(f(x) - fk, 0)).^2;
        tit_str = 'P_4: Sahiner et al. (2025) One-Parameter';
        
    case 'P5'
        % P5: Wang et al. (2012) Parameter-Free
        % Equation: P5 = 1 / (1+||x-xk||^2) - arctan([min(0, f(x)-f(xk))]^2)
        ff_func = @(x, xk, fk) 1 ./ (1 + (x - xk).^2) - atan((min(0, f(x) - fk)).^2);
        tit_str = 'P_5: Wang et al. (2012) Parameter-Free';
        
    case 'P6'
        % P6: Yilmaz (2025) Space-Filling / Auxiliary
        % Equation: P6 = phi1(f(x)-f(xk)) - theta * phi2(x-xk) + f(xk)
        theta = 0.05;   % A "sufficiently small" value
        eps_val = 1e-4; % Smoothing parameter from Algorithm 1
        
        % Piecewise phi_1 function
        phi1 = @(t) 0 .* (t >= 0) + ...
                    (-(1/eps_val^2)*t.^3 - (2/eps_val)*t.^2) .* (t > -eps_val & t < 0) + ...
                    t .* (t <= -eps_val);
                
        % Piecewise phi_2 function (Strictly C1 Continuous)
        phi2 = @(dz) dz .* (dz >= eps_val) + ...
                     ((dz.^2)/(2*eps_val) + eps_val/2) .* (dz > -eps_val & dz < eps_val) + ...
                     (-dz) .* (dz <= -eps_val);
                 
        ff_func = @(x, xk, fk) phi1(f(x) - fk) - theta * phi2(x - xk) + fk;
        tit_str = 'P_6: Yilmaz (2025) Space-Filling / Auxiliary';
end

% Search Points (Sequence: 0 -> 3 -> -5 -> 12)
xk_stars = [0, 3, -5, 12];
fk_stars = arrayfun(f, xk_stars);

% --- 4. Visualization of Filled Function Iterations ---
figure('Name', ['Filled Function Iterations: ', selected_FF], 'Color', 'w', 'Position', [700, 100, 1000, 800]);
colors = [0 0.4470 0.7410; 0.8500 0.3250 0.0980]; % Professional Blue and Orange

for i = 1:4
    subplot(2, 2, i);
    hold on; grid on; box on;
    
    current_xk = xk_stars(i);
    current_fk = fk_stars(i);
    
    % Plot Objective Function
    plot(x, fx, 'Color', colors(1,:), 'LineWidth', 2, 'DisplayName', '$f(x)$');
    
    % Plot Selected Filled Function (Take real part to avoid complex number artifacts)
    px = arrayfun(@(val) real(ff_func(val, current_xk, current_fk)), x);
    
    % Clamp P(x) to axis limits to prevent visual overflow
    px(px > 15) = 15; px(px < -15) = -15; 
    
    plot(x, px, 'Color', colors(2,:), 'LineWidth', 1.8, 'DisplayName', ['$P_{', num2str(i), '}(x, x_k^\ast)$']);
    
    % Current Minimum
    plot(current_xk, current_fk, 'rs', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'DisplayName', 'Current $x_k^\ast$');
    
    % Reference Line (Dashed Line)
    line([-12, 16], [current_fk, current_fk], 'Color', [0.4 0.4 0.4], ...
        'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', 'Reference Level $f(x_k^\ast)$');
        
    title(['\textbf{Iteration ', num2str(i), ': Search from } $x_', num2str(i), '^\ast$'], ...
        'FontSize', 13, 'Interpreter', 'latex');
    xlabel('$x$', 'Interpreter', 'latex');
    ylabel('$f(x), P(x)$', 'Interpreter', 'latex');
    
    % Axis limits
    ylim([-6, 8]); 
    xlim([-12, 16]);
    
    if i == 1
        legend('Location', 'best', 'Interpreter', 'latex', 'FontSize', 10);
    end
    set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 11, 'LineWidth', 1);
end

% Main Title
sgtitle(['Comparison: ', tit_str], 'FontSize', 15, 'FontWeight', 'bold');
