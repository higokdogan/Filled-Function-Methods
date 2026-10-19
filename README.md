



# 🏔️ Filled Function Methods in Global Optimization

Welcome to my repository on **Filled Function Methods (FFM)**. This page is dedicated to exploring deterministic approaches for escaping local minima in continuous global optimization, highlighting theoretical evolution, handling real-world engineering constraints, and showcasing recent academic research.

---

## 📌 1. The Local Minima Trap
In non-convex continuous optimization, objective functions often possess numerous local minima. The standard unconstrained problem is formulated as:

$$
\min_{x \in X} f(x)
$$

Traditional gradient-based local search algorithms get easily trapped at a local minimum ${x_1^\ast}$, as all surrounding points yield higher objective values.

---

## 💡 2. The Core Logic: What is a Filled Function?
Introduced by R.P. Ge (1990), the Filled Function Method is a powerful deterministic strategy. Once a local minimum ${x_1^\ast}$ is found, an auxiliary function, $P(x, {x_1^\ast})$, is constructed to transform the landscape. 

A valid filled function must satisfy three fundamental criteria:
1. **Strict Maximization:** ${x_1^\ast}$ becomes a strict local maximizer of $P(x)$.
2. **No False Traps:** There are no stationary points of $P(x)$ in regions where $f(x) \geq f({x_1^\ast})$.
3. **Guaranteed Escape:** A local minimizer of $P(x)$ must exist in the region where $f(x) < f({x_1^\ast})$.

Minimizing $P(x)$ forces the search into a lower basin of $f(x)$, allowing a subsequent local search to yield a *better* local minimum ${x_2^\ast}$.

---

## 🛠️ 3. Handling Real-World Constraints: The Penalty Function Approach
Most real-world engineering challenges, such as structural design or layout optimizations, are heavily constrained by physical, geometric, or operational limitations. Since classical gradient-based Filled Function Methods operate on unconstrained domains, the problem must first be mathematically transformed.

### Transforming Constrained Problems
Physical constraints are typically expressed as equality $h_i(x) = 0$ and inequality $g_j(x) \leq 0$ conditions. To seamlessly integrate these into the original objective function $f(x)$, the **Exterior Penalty Function Method** is utilized. 

By assigning a significantly large penalty parameter ($\mu > 0$) to any constraint violation, the constrained problem is transformed into an unconstrained, non-convex optimization problem. The generalized penalized objective function, $F_p(x)$, is formulated as:

$$ 
\min_{x \in \mathbb{R}^n} F_p(x) = f(x) + \mu \sum_{i=1}^{m} [h_i(x)]^2 + \mu \sum_{j=1}^{p} [\max(0, g_j(x))]^2 
$$

### Enabling the Filled Function
Through this penalty transformation, an initially constrained and rigid engineering problem is rendered into a completely unconstrained landscape. The high penalty cost naturally forces the search algorithm to converge toward the feasible region. This creates the perfect mathematical setup for the Filled Function Method, allowing the algorithm to smoothly compute gradients, construct auxiliary functions, and execute global escapes without crashing into rigid boundaries.

---

## 📚 4. Historical Evolution & 6 Key Formulations
The development of FFMs has been a continuous struggle against numerical instability, discontinuity, and parameter dependency. In Ge's foundational 1987 paper, it was shown that inappropriate parameter tuning leads to "false local maxima" or severe "numerical overflow." 

Here is the evolution of 6 critical formulations addressing these challenges:

### 1. The Logarithmic Model (Ge & Qin)
The foundational formulation relied on logarithmic penalties. However, the requirement to tune $\rho$ and $r$ precisely often led to "false local maxima" if $\rho$ was too large.

$$
P_1(x, {x_k^\ast}, \rho, r) = -\left(\rho^2 \ln[r+f(x)] + \| x - {x_k^\ast} \|^2\right)
$$

*(Ref: Ge, R. P., & Qin, Y. F. (1987). "A class of filled functions for finding global minimizers of a function of several variables." Journal of Optimization Theory and Applications, 54(2), 241-252.)*

### 2. The Exponential Model (Ge, 1990)
Introduced to avoid logarithmic domain restrictions, this model faced severe **numerical overflow** issues in high-dimensional spaces because of the $\exp$ term.

$$
P_2(x, {x_k^\ast}, \gamma) = -[f(x)-f({x_k^\ast})] \exp(\gamma \| x - {x_k^\ast} \|^2)
$$

*(Ref: Ge, R. P. (1990). "A filled function method for finding a global minimizer of a function of several variables." Mathematical Programming, 46(1-3), 191-204.)*

### 3. The Discontinuous Model (Liu, 2002)
To completely remove the problematic exponential terms, Liu proposed $P_3$. While it solved overflow issues, it broke the continuous differentiability ($C^1$) of the solution space.

$$
P_3(x, {x_k^\ast}, \gamma) = \frac{1}{\ln[1+f(x)-f({x_k^\ast})]} - \gamma \| x - {x_k^\ast} \|^2
$$

*(Ref: Liu, X. (2002). "Several filled functions with mitigators." Applied Mathematics and Computation, 133(2-3), 375-387.)*

### 4. The One-Parameter Model (Şahiner et al., 2025)
To address both discontinuity and numerical instability simultaneously, Şahiner et al. introduced a bounded one-parameter model to solve the Facility Layout Problem, significantly reducing the tuning burden.

$$
P_4(x, {x_k^\ast}, a) = \exp(-\| x - {x_k^\ast} \|^2) - a\left[\min(f(x)-f({x_k^\ast}),0)\right]^2
$$

*(Ref: Şahiner, A., Ermiş, T., Başağaoğlu Fındık, A., Awan, M. W., & Özdemir, G. (2025). "A new filled function for global optimization and its deterministic efficiency in solving the facility layout/location problem." Engineering Optimization, 57(4), 1073-1086.)*

### 5. Parameter-Free Formulations (Wang et al., 2012)
Modern approaches aim to eliminate parameter dependency. Wang et al. proposed a parameter-free model ($P_5$) using inverse quadratics and arctangent functions to ensure stability.

$$
P_5(x, {x_k^\ast}) = \frac{1}{1+\| x - {x_k^\ast} \|^2} - \arctan\left(\min[0, f(x)-f({x_k^\ast})]^2\right)
$$

*(Ref: Wang, W. X., Shang, Y. L., & Zhang, Y. A. (2012). "Finding global minima with a novel filled function for non-smooth unconstrained optimisation." International Journal of Systems Science, 43(4), 707-714.)*

### 6. Space-Filling Curve & Auxiliary Function Approach (Yılmaz, 2025)
This approach combines the space-filling curves technique to reduce problem dimensionality with a novel auxiliary function approach. It enables direct control of the slope using only a single parameter ($\theta$) and shows high success in solving complex real-world problems like Economic Load Dispatch (ELD).

$$
P_6(z, {z_k^\ast}) = \varphi_1(z, {z_k^\ast}) - \theta\varphi_2(z, {z_k^\ast}) + g_\alpha({z_k^\ast})
$$

where $t = g_\alpha(z) - g_\alpha({z_k^\ast})$,

$$
\varphi_1(z, {z_k^\ast}) = \begin{cases} 
t, & t \geq 0 \\ 
-\frac{1}{\epsilon^2}t^3 - \frac{2}{\epsilon}t^2, & -\epsilon < t < 0 \\ 
0, & t \leq -\epsilon 
\end{cases}
$$

and

$$
\varphi_2(z, {z_k^\ast}) = \begin{cases} 
z - {z_k^\ast}, & z - {z_k^\ast} \geq \epsilon \\ 
\frac{(z - {z_k^\ast})^2}{2\epsilon} + \frac{\epsilon}{2}, & -\epsilon < z - {z_k^\ast} < \epsilon \\ 
{z_k^\ast} - z, & z - {z_k^\ast} \leq -\epsilon 
\end{cases}
$$

*(Ref: Yilmaz, N. (2025). "A new global optimization algorithm based on space-filling curve and auxiliary function approach and its applications." Communications in Nonlinear Science and Numerical Simulation, 149, 108920.)*

## 💻 5. Visualizing the Escape: The Filled Function in Action

To truly understand the power of the Filled Function Method, we can visualize its step-by-step behavior on a highly multimodal landscape. 

### The Objective Function Landscape
Let's define a non-convex objective function $f(x)$ constructed using inverse quadratic terms to create multiple challenging valleys (local minima). The function is defined as:

$$
f(x) = 4 - \sum_{i=1}^{4} \frac{a_i}{1 + (x - b_i)^2}
$$

where the parameters are $a = \{7, 3, 5, 9\}$ and $b = \{-5, 0, 3, 12\}$. 

Traditional gradient-based algorithms would immediately get trapped in the first valley they encounter. As seen below, the function has several shallow basins, with the true **Global Optimum** hiding in the deepest basin on the far right.

<div align="center">
  <img width="796" height="601" alt="Objective Function Landscape" src="https://github.com/user-attachments/assets/00d01702-578e-4917-8b73-dd06b0e52747" />
</div>

### The Iterative Escape (The Story of $P_4$)
To demonstrate how a filled function mathematically forces an algorithm to escape these traps, we apply **The One-Parameter Model ($P_4$)** by Şahiner et al. (2025). The algorithm dynamically alters the landscape to "fill" the current basin and push the search towards a better one.

<div align="center">
 <img width="1281" height="1136" alt="pic22" src="https://github.com/user-attachments/assets/5583c574-ccbf-43f0-9550-91b0cddc9f5c" />
</div>

**The Magic of the Reference Line (Dashed Line):**
Notice the gray dashed line in each iteration. This represents the current function value $f(x_k^\ast)$. The brilliance of the Filled Function Method lies here: **any local minimum sitting above this dashed line becomes entirely invisible (unresponsive) to the algorithm.** The algorithm strictly masks out inferior regions and only allows the search to fall into basins that are strictly deeper than the current one.

Here is the narrative of the algorithm's journey:
* **Iteration 1:** The search begins and gets trapped at a shallow local minimum near $x = 0$. The algorithm constructs the filled function $P_4(x)$ (the orange line), which peaks exactly at this point, effectively inverting the valley into a hill. Notice how the basin at $x=3$ is completely masked because it is higher than our dashed reference line. The algorithm is mathematically forced to slide left into a deeper valley.
* **Iteration 2 (Educational Scenario):** *For demonstration purposes*, imagine the search fell into the local minimum near $x = 3$. A new $P_4(x)$ is constructed to fill this specific basin. The dashed line drops, and the algorithm is pushed out again.
* **Iteration 3:** The search is pushed further down into a much deeper minimum on the left side ($x = -5$). The dashed line drops significantly. Once again, the filled function masks this basin, and because all central basins are now above the dashed line, they remain flat (unresponsive). The algorithm has no choice but to look elsewhere.
* **Iteration 4:** Driven by the deterministic mechanics of $P_4(x)$, the algorithm is guided to the absolute lowest point—the **Global Minimum** near $x = 12$.

**A Note on Algorithmic Flexibility:** 
*This specific 4-step sequence is a didactic scenario designed to visually demonstrate the fundamental concept of "basin filling" and "masking." In a real-world execution, the algorithm does not strictly require this exact, sequential zigzag path. Depending on the initial starting point, the gradient flow, and the specific auxiliary function used, the algorithm might locate the global optimum in just one or two iterations. The absolute guarantee of the FFM is its deterministic ability to consistently reject higher local minima and move to a lower basin until the global minimum is found.

---

## ⚖️ 6. Advantages & Limitations of FFM

Before diving into the computational implementation, it is crucial to summarize the theoretical strengths and inherent challenges of the Filled Function Method compared to traditional heuristic and local search algorithms.

### Strengths (Advantages)
* **Mathematical Rigor & Determinism:** Unlike stochastic methods (e.g., Genetic Algorithms, PSO), FFM relies on exact mathematical theorems. Its ability to escape local minima and converge toward the global optimum is theoretically provable.
* **Strictly Monotonic Descent:** The algorithm mathematically guarantees that every new basin discovered will have a strictly lower objective function value than the previous one. The search process never regresses to a worse state.
* **Dynamic Basin Masking:** The construction of the auxiliary function not only transforms the current trap into a peak but also structurally masks (renders unresponsive) all other shallower local minima, forcing the algorithm to focus only on deeper valleys.
* **Low Computational & Memory Cost:** Because it relies on a single-point trajectory rather than a large population of agents, its memory (RAM) footprint and CPU load are extremely low. This is highly practical for complex engineering problems where function evaluations are expensive.
* **High Local Precision:** By integrating with powerful gradient or Hessian-based local solvers (e.g., Quasi-Newton) during the local search stage, FFM pinpoints the exact bottom of every basin with exceptional mathematical precision.

### Limitations (Disadvantages)
* **Mathematical Transformation Side Effects (Basin Shrinking):** As seen in the visualizations above, constructing the auxiliary function can severely shrink the "basin of attraction" of deeper valleys. If the step size is not calibrated correctly, the algorithm might step over these narrowed basins entirely. Additionally, exponential terms can create wide, flat regions (gradient vanishing) where local solvers may stall.
* **Curse of Dimensionality:** Escaping a basin heavily depends on the defined search directions during the global search step. As the problem dimensions increase, the number of potential search directions required to successfully find a lower basin grows exponentially, which can increase computational overhead.
* **Strict Dependency on Local Solvers:** The overall success of FFM is directly tied to the performance of the underlying local search algorithm (e.g., `fminunc`) used throughout both the local minimization and basin-escaping steps. If the problem is highly noisy, discontinuous, or has overly rigid constraints that cause the local solver to fail, the core escape mechanism of the FFM will also be disrupted.

---

## 🚀 7. Implementation & Usage Guide

While the theoretical illustrations above demonstrate the deterministic mechanics of basin-filling and masking, the true utility of the Filled Function Method lies in its computational application. 

To facilitate academic replication, extensive benchmark testing, and the integration of novel search strategies, this repository has been structured with a strictly modular MATLAB architecture. Researchers can easily swap objective functions, apply different filled function formulations, and test various local search subroutines.

For comprehensive instructions on how to initialize the test functions, configure the auxiliary parameters, and execute the core global optimization loops within your local environment, please refer to the **[Usage Guide](USAGE.md)**.
