
# Filled Function Methods in Global Optimization 🏔️

Welcome to my repository dedicated to **Filled Function Methods (FFM)** in deterministic global optimization. This repository serves as an interactive educational resource and a showcase of my academic research.

## 📌 1. The Local Minima Problem
In continuous global optimization, objective functions often have numerous local minima. The standard optimization problem is defined as:
$$ \min_{x \in X} f(x) $$
When a local search algorithm finds a local minimum $x_1^*$, traditional gradient-descent methods cannot escape it because surrounding points have higher objective values.

## 💡 2. What is a Filled Function?
The **Filled Function Method**, originally introduced by R.P. Ge (1990), is a powerful deterministic approach to escape these local minima. 

Once a local minimum $x_1^*$ is found, an auxiliary function $P(x, x_1^*)$ is constructed. This function has unique properties:
- The current local minimum $x_1^*$ becomes a strictly local maximum of $P(x)$.
- There are no local minima or saddle points of $P(x)$ higher than $f(x_1^*)$.
- Minimizing $P(x)$ forces the search to move into a lower basin of $f(x)$. Once a suitable point is found, a new local search minimizes $f(x)$ to find a *better* local minimum $x_2^*$.

## 📚 3. Evolution & Literature
* **Classical Parameter-Dependent FFMs:** Early filled functions required tuning multiple penalty parameters, which could lead to numerical instability.
* **Modern Approaches:** The literature has evolved towards parameter-free methods and continuously differentiable functions to improve computational efficiency.

## 🚀 4. My Research & Contributions
During my Ph.D. research at Süleyman Demirel University, I focus on enhancing the efficiency of FFMs for complex engineering problems. My main contributions include:
- **Parameter-Free Approaches:** Combining filled functions with exterior penalty methods for constrained structural design optimization.
- **Sech-Quadratic Filled Functions:** Utilizing Sobol sequence-driven directional search strategies to accelerate the exploration phase.

## 💻 5. MATLAB Codes & Benchmarks
*(Coming soon: MATLAB implementations, numerical experiments, and benchmark engineering problems like pressure vessels, tension/compression springs, etc.)*
