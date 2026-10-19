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
Let's define a non-convex objective function $f(x)$ characterized by multiple challenging valleys (local minima). Traditional gradient-based algorithms would immediately get trapped in the first valley they encounter. 

As seen below, the function has several shallow basins, with the true **Global Optimum** hiding in the deepest basin on the far right[cite: 46].

![Objective Function Landscape](pic1.eps)
*(Note: Ensure the image file is uploaded to your repository and the path is correct.)*

### The Iterative Escape (The Story of $P_4$)
To demonstrate how a filled function mathematically forces an algorithm to escape these traps, we apply **The One-Parameter Model ($P_4$)** by Şahiner et al. (2025). The algorithm dynamically alters the landscape to "fill" the current basin and push the search towards a better one[cite: 47].

![Filled Function Iterations](pic2.eps)

Here is the narrative of the algorithm's journey[cite: 47]:
* **Iteration 1:** The search begins and gets trapped at a shallow local minimum near $x = 0$[cite: 47]. The algorithm constructs the filled function $P(x)$ (the orange line), which peaks exactly at this point, effectively inverting the valley into a hill to force the search out[cite: 47].
* **Iteration 2:** Escaping the first trap, the algorithm falls into a slightly better local minimum near $x = 3$[cite: 47]. A new $P(x)$ is constructed to fill this new basin[cite: 47].
* **Iteration 3:** The search is pushed further down into a much deeper minimum on the left side ($x = -5$)[cite: 47]. Once again, the filled function masks this basin[cite: 47].
* **Iteration 4:** Driven by the deterministic mechanics of $P(x)$, the algorithm finally reaches the absolute lowest point—the **Global Minimum** near $x = 12$[cite: 47].

**A Note on Algorithmic Efficiency:** 
*This specific 4-step sequence is designed to visually demonstrate the fundamental concept of "basin filling." In a real-world execution, the algorithm does not strictly require this exact sequential path; it dynamically navigates the landscape based on its starting point and can often locate the global optimum in fewer iterations. The core guarantee is its deterministic ability to consistently move to a lower basin until the global minimum is found.*
