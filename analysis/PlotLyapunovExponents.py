# Computes the Lyapunov exponents for a given chaotic function and plots them

import numpy as np
import matplotlib.pyplot as plt
import numba
import math

# Change this function to swap between different chaotic functions.
# (You will want to jit this function, or else the computation will be slow)
@numba.jit(nopython=True)
def chaotic_update(x0, a):
    # Logistic map
    return a*x0*(1-x0)
    
    # Tent map
    # The wrap is needed for xnor to have a solution
    
    """
    x0 %= 1

    if (x0 <= 0.5):
        return a * x0
    elif (x0 <= 1):
        return a * (1 - x0)
    """
    
# This function should compute the derivitave of the function evaluated at x0
# It should match the chaotic function in chaotic_update
# (You will want to jit this function, or else the computation will be slow)
@numba.jit(nopython=True)
def chaotic_derivitave(x0, a):
    # Logistic map
    return a - (2*a*x0)
    
    # Tent map
    """
    if (x0 <= 0.5):
        return a
    elif (x0 <= 1):
        return -a
    """
        
# (You will want to jit this function, or else the computation will be slow)
@numba.jit(nopython=True)
def get_time_series(initial_condition, a, num_iter):
    output = np.zeros((num_iter,), dtype=np.float64)
    
    output[0] = initial_condition
    for i in range(1, num_iter, 1):
        output[i] = chaotic_update(output[i-1], a)
        
    return output
    
# Estimates the lyapunov exponent by computing the trajectories created by x0 and x1
#   and fitting an exponential function to the difference
#
# This methods is numerically unstable, and is only used to contrast with the optimized method. 
def get_lyapunov_pair_estimate(x0, x1, a, num_iter):
    x0_series = get_time_series(x0, a, num_iter)
    x1_series = get_time_series(x1, a, num_iter)
    
    difference = np.abs(x0_series - x1_series)
    
    chop_point = difference.shape[0]
    for i in range(0, difference.shape[0], 1):
        if (difference[i] >= 0.1 or difference[i] == 0):
            chop_point = i
            break
    
    difference = difference[:chop_point]
    
    time = np.array([i for i in range(difference.shape[0])], dtype=np.float64)
    fit = np.polyfit(time, np.log(difference), deg=1, full=False)
    
    exponent = fit[0]
    
    return exponent
    
# Uses the derivitave trick to compute the lyapunov exponent.
def get_lyapunov_pair_numeric(x0, a, num_iter):
    x0_series = get_time_series(x0, a, num_iter)
    sum = 0
    for x0 in x0_series:
        sum += np.log(np.abs(chaotic_derivitave(x0, a)))
    sum /= x0_series.shape[0]
    
    return sum
    
if __name__ == '__main__':
    
    # Set a_values to the range for which you want to plot
    #a_values = np.arange(0.01, 2.01, 0.01, dtype=np.float64)
    a_values = np.arange(0.01, 4.01, 0.01, dtype=np.float64)
    
    # The starting separation for the trajectories used in the estimation method
    epsilon = 0.0000001
    x0_values = np.arange(0.1, 1, 0.1, dtype=np.float64)
    x1_values = x0_values + epsilon
    
    # The number of iterations to compute for the estimation method
    num_iter = 100
    
    final_exponents_estimate = []
    final_exponents_numeric = []
    for a_value in a_values:
        estimate_exponents = []
        numeric_exponents = []
        for i in range(0, x0_values.shape[0], 1):
            estimate_exponent = get_lyapunov_pair_estimate(x0_values[i], x1_values[i], a_value, num_iter)
            numeric_exponent = get_lyapunov_pair_numeric(x0_values[i], a_value, num_iter)
            
            # Occasionally, curve fitting will fail. This seems to happen at critical points (e.g. x0 = 0.5 for the tent map function)
            #   Exclude those values from the computation.
            is_valid_estimate = (not math.isinf(estimate_exponent)) and (not math.isnan(estimate_exponent))
            is_valid_numeric = (not math.isinf(numeric_exponent)) and (not math.isnan(numeric_exponent))
            if (is_valid_estimate and is_valid_numeric):
                estimate_exponents.append(estimate_exponent)
                numeric_exponents.append(numeric_exponent)
        
        final_exponents_estimate.append(np.max(estimate_exponents))
        final_exponents_numeric.append(np.max(numeric_exponents))
        
    fig, ax = plt.subplots(nrows=1, ncols=1, figsize=(10, 10))
    ax.scatter(a_values, final_exponents_estimate, s=1, label='estimate')
    ax.scatter(a_values, final_exponents_numeric, s=1, label='numeric')
    
    stability_line = np.array([0 for i in range(a_values.shape[0])], dtype=np.float64)
    ax.scatter(a_values, stability_line, s=3, label='stability line')
    
    ax.set_ylim(-3, 1)
    ax.legend()
    
    ax.set_title('Maximum Lyapunov exponent for logistic map', fontweight='bold')
    #ax.set_title('Maximum Lyapunov exponent for tent map', fontweight='bold')
    ax.set_xlabel('a', fontweight='bold')
    ax.set_ylabel('exponent', fontweight='bold')
    plt.savefig('lyapunov.png')
    plt.show()
