# 🛠️ Usage Guide: Filled Function Optimization

This repository is designed to be highly modular, separating the core optimization search algorithms from the test environments (objective functions) and the auxiliary filled functions. This structure allows researchers to easily plug in new test functions or experiment with different search strategies.

## 📂 Repository Structure

The current active files in the repository are:

* **`main.m`**: The primary execution script. Currently, it utilizes a standard coordinate-directional search strategy (Phase 1 Local Search + Phase 2 Basin Escaping).
* **`benchmark.m`**: A standalone library containing 41 continuous global optimization test functions (e.g., Rastrigin, Rosenbrock, Shekel, etc.). 
* **`get_filled_function.m`**: The library of auxiliary filled functions (`P1` through `P6`). It mathematically constructs the peak to escape local minima.
* **`FF_Simulation_P1_to_P6.m`**: A theoretical simulation script used to generate 2D visual landscapes of the basin-filling mechanics.

---

## 🚀 Quick Start Guide

To run a global optimization test on your local MATLAB environment, you only need to interact with the algorithm execution scripts (currently `main.m`).

### 1. Initial Setup
Clone or download the repository to your local machine and open `main.m` in MATLAB.

### 2. Configure the Objective Function
Locate the "Problem Initialization" section in the code. Set the `pn` (problem number) variable to choose a benchmark function from the library.
* *Example:* `pn = 5` for Six-Hump Camel, `pn = 19` for Rastrigin.
* Set the dimensionality of the problem using `n_dim` (ensure the dimension matches the function's requirements).

```matlab
% --- 1. Problem Initialization ---
pn = 19;      % Select Rastrigin Function
n_dim = 2;    % Set Dimension
[f, lb, ub, f_true, func_name] = benchmark(pn, n_dim);
```

### 3. Select the Filled Function
Locate the "Filled Function Selection" section. Set the `ff_id` variable to choose the auxiliary function strategy you wish to test.
* *Example:* `ff_id = 'P4'` for the Sahiner et al. (2025) formulation.

```matlab
% --- 2. Filled Function Selection ---
ff_id = 'P4'; 
P = get_filled_function(ff_id, f);
```

### 4. Adjust Search Parameters (Optional)
You can modify the `step_size` or `max_iter` in the "Algorithm Parameters" section to observe how the step size affects the basin escaping phase for different topographical structures.

### 5. Execute and Evaluate
Run the script. The algorithm dynamically tracks and prints its escape trajectory to the MATLAB console. It provides a comprehensive breakdown of:
* The initial local minimum trap.
* Iterative basin escapes (new local minima found).
* Total Function Evaluations (`feval`).
* CPU Time (seconds).

This output is formatted to allow for direct tabular comparisons in academic reporting.
