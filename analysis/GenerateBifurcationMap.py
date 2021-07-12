# Generates a plot of the chaotic function, as well as the bifurcation map

import numpy as np
import matplotlib.pyplot as plt
import numba

@numba.jit(nopython=True)
def run_logistic_function(a, x0, num_iter):
    for i in range(num_iter):
        x0 = a*x0*(1-x0)
    
    return x0
    
@numba.jit(nopython=True)
def run_tent_map_function(a, x0, num_iter):
    for i in range(num_iter):
        if (x0 < 0.5):
            x0 = a * x0
        elif (x0 <= 1.0):
            x0 = a * (1 - x0)
        else:
            # This is yucky organization, but this should only be able to happen once for well-behaved functions
            x0 = x0 - 1
            if (x0 < 0.5):
                x0 = a * x0
            else:
                x0 = a * (1 - x0)
    
    return x0

@numba.jit(nopython=True)
def run_dyadic_transform(a, x0, num_iter):
    for i in range(num_iter):
        x0 = (2 * x0) % 1

    return x0
    
def sweep_bifurcation(a_values, x0_values, num_iter):
    idx = 0
    num_elements = a_values.shape[0] * x0_values.shape[0]
    output_a_values = np.zeros(shape=(num_elements), dtype=np.float64)
    converge_values = np.zeros(shape=(num_elements), dtype=np.float64)
    for a_value in a_values:
        for x0_value in x0_values:
            
            ##########################################
            # Select the chaotic function to use here.
            ##########################################
            
            #converged_value = run_logistic_function(a_value, x0_value, num_iter)
            converged_value = run_tent_map_function(a_value, x0_value, num_iter)
            #converged_value = run_dyadic_transform(a_value, x0_value, num_iter)
            
            output_a_values[idx] = a_value
            converge_values[idx] = converged_value
            idx += 1
            
    return output_a_values, converge_values
    
def plot_bifurcation(a_values, converge_values, title, ax):
    if (len(a_values) != len(converge_values)):
        raise ValueError("Shapes of a_values and converge_values are not the same.")
    
    ax.scatter(a_values, converge_values, s=1)
    ax.set_title(title, fontweight="bold")
    ax.set_xlabel("a", fontweight="bold")
    ax.set_ylabel("converged value", fontweight="bold")
    
def plot_values(x, y, title, ax):
    ax.scatter(x, y, s=1)
    ax.set_title(title, fontweight="bold")
    ax.set_xlabel("x", fontweight="bold")
    ax.set_ylabel("f(x)", fontweight="bold")
    
def main():
    fig, ax = plt.subplots(nrows=1, ncols=2, figsize=(20, 10))
    
    #fig.suptitle("Logistic map", fontweight="bold")
    fig.suptitle("Tent map", fontweight="bold")
    
    # plot the graph
    xs = np.arange(0, 1, 0.001, dtype=np.float64)
    #ys = np.array([run_logistic_function(4, xs[i], 1) for i in range(xs.shape[0])], dtype=np.float64)
    ys = np.array([run_tent_map_function(2, xs[i], 1) for i in range(xs.shape[0])], dtype=np.float64)
    plot_values(xs, ys, "Tent map function for a=2", ax[0])
    
    a_values = np.arange(0, 2, 0.001, dtype=np.float64)
    x_values = np.arange(0.15, 0.95, 0.01, dtype=np.float64)
    num_iter = 2000
    
    plot_a_values, plot_converge_values = sweep_bifurcation(a_values, x_values, num_iter)
    plot_bifurcation(plot_a_values, plot_converge_values, "Bifurcation map", ax[1])
    
    plt.savefig("bifurcation.png")
    
    plt.show()
    
if __name__ == "__main__":
    main()
