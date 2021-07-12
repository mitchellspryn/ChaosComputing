# Searches for logic gate thresholds that solve the logical constraints

import math
import itertools
import json

import numpy as np
import numba

DELTA_TOL = 0.000001

# Update this function to change the chaotic function in use
#   You'll want to jit this, or else the search will take a long amount of time
@numba.jit(nopython=True)
def chaotic_update(x0):
    # Logistic map
    #return 4*x0*(1-x0)
    
    # Dyadic transform
    #return (2 * x0) % 1
    #if (x0 <= 0.5):
    #    return 2 * x0
    #else:
    #    return (2 * x0) - 1
    
    # Tent map
    # The wrap is needed for xnor to have a solution
    x0 %= 1
    a = 2

    if (x0 <= 0.5):
        return a * x0
    elif (x0 <= 1):
        return a * (1 - x0)
        
@numba.jit(nopython=True)
def is_close(a, b):
    return (np.abs(a-b) < DELTA_TOL)
    
@numba.jit(nopython=True)
def check_and_condition(x0, x_crit, delta, ll, lh, hh):
    return ((ll <= x_crit) and (lh <= x_crit) and is_close(hh-x_crit, delta))
    
@numba.jit(nopython=True)
def check_or_condition(x0, x_crit, delta, ll, lh, hh):
    return ((ll <= x_crit) and is_close(lh-x_crit, delta) and is_close(hh-x_crit, delta))
    
@numba.jit(nopython=True)
def check_xor_condition(x0, x_crit, delta, ll, lh, hh):
    return((ll <= x_crit) and is_close(lh-x_crit, delta) and (hh <= x_crit))
    
@numba.jit(nopython=True)
def check_nand_condition(x0, x_crit, delta, ll, lh, hh):
    return (is_close(ll-x_crit, delta) and is_close(lh-x_crit, delta) and (hh <= x_crit))

@numba.jit(nopython=True)
def check_nor_condition(x0, x_crit, delta, ll, lh, hh):
    return (is_close(ll-x_crit, delta) and (lh <= x_crit) and (hh <= x_crit))

@numba.jit(nopython=True)
def check_xnor_condition(x0, x_crit, delta, ll, lh, hh):
    return (is_close(ll-x_crit, delta) and (lh <= x_crit) and is_close(hh-x_crit, delta))
 
# For some reason gives warnings about not being able to parallelize  
@numba.jit(nopython=True)
def solution_search(possible_deltas, possible_x0, possible_x_crit):
    solutions = []
    for delta in possible_deltas:
        print(delta)
        for x0 in possible_x0:
            for x_crit in possible_x_crit:
                ll = chaotic_update(x0)
                lh = chaotic_update(x0 + delta)
                hh = chaotic_update(x0 + delta + delta)
                
                if (check_and_condition(x0, x_crit, delta, ll, lh, hh)):
                    solutions.append((x0, x_crit, delta, 'and'))
                if (check_or_condition(x0, x_crit, delta, ll, lh, hh)):
                    solutions.append((x0, x_crit, delta, 'or'))
                if (check_xor_condition(x0, x_crit, delta, ll, lh, hh)):
                    solutions.append((x0, x_crit, delta, 'xor'))
                if (check_nand_condition(x0, x_crit, delta, ll, lh, hh)):
                    solutions.append((x0, x_crit, delta, 'nand'))
                if (check_nor_condition(x0, x_crit, delta, ll, lh, hh)):
                    solutions.append((x0, x_crit, delta, 'nor'))
                if (check_xnor_condition(x0, x_crit, delta, ll, lh, hh)):
                    solutions.append((x0, x_crit, delta, 'xnor'))
    
    return solutions
    
def collect_solutions(solutions):
    output = {}
    for solution in solutions:
        x0 = solution[0]
        x_crit = solution[1]
        delta = solution[2]
        value = solution[3]
        
        if delta not in output:
            blank_dict = {}
            blank_dict['and'] = []
            blank_dict['or'] = []
            blank_dict['xor'] = []
            blank_dict['nand'] = []
            blank_dict['nor'] = []
            blank_dict['xnor'] = []
            output[delta] = blank_dict
            
        output[delta][value].append((x0, x_crit))
        
    return output

def print_valid_solution(solution, delta):
    and_solution = (-1, -1)
    or_solution = (-1, -1)
    xor_solution = (-1, -1)
    nand_solution = (-1, -1)
    nor_solution = (-1, -1)
    xnor_solution = (-1, -1)

    if ('and' in solution and len(solution['and']) > 0):
        and_solution = solution['and'][0]
    if ('or' in solution and len(solution['or']) > 0):
        or_solution = solution['or'][0]
    if ('xor' in solution and len(solution['xor']) > 0):
        xor_solution = solution['xor'][0]
    if ('nand' in solution and len(solution['nand']) > 0):
        nand_solution = solution['nand'][0]
    if ('nor' in solution and len(solution['nor']) > 0):
        nor_solution = solution['nor'][0]
    if ('xnor' in solution and len(solution['xnor']) > 0):
        xnor_solution = solution['xnor'][0]

    print('     -------------------------------------------------------------------------------------------')
    print('     |  One solution for delta = {0:.8f}                                                    |'.format(delta))
    print('     -------------------------------------------------------------------------------------------')
    print('     |     AND      |      OR      |      XOR     |      NAND    |      NOR     |      XNOR    |')
    print('------------------------------------------------------------------------------------------------')
    print('| x0 | {0:.10f} | {1:.10f} | {2:.10f} | {3:.10f} | {4:.10f} | {5:.10f} |'.format(
        and_solution[0], or_solution[0], xor_solution[0], nand_solution[0], nor_solution[0], xnor_solution[0]))
    print('------------------------------------------------------------------------------------------------')
    print('| xc | {0:.10f} | {1:.10f} | {2:.10f} | {3:.10f} | {4:.10f} | {5:.10f} |'.format(
        and_solution[1], or_solution[1], xor_solution[1], nand_solution[1], nor_solution[1], xnor_solution[1]))
    print('------------------------------------------------------------------------------------------------')
    print()
    print()
 

def main():
    #bits_of_precision = 12
    bits_of_precision = 3
    divisor = float(2**bits_of_precision)

    possible_deltas = np.array(list([i / divisor for i in range(1, int(divisor), 1)]), dtype=np.float64)
    possible_x0 = np.array(list([i / divisor for i in range(int(divisor))]), dtype=np.float64)
    possible_x_crit = np.array(list([i / divisor for i in range(int(divisor))]), dtype=np.float64)
    
    solutions = solution_search(possible_deltas, possible_x0, possible_x_crit)
    solutions = collect_solutions(solutions)
    
    num_valid_solutions = 0
    for key in solutions:
        if ((len(solutions[key]['and']) > 0)
            and (len(solutions[key]['or']) > 0)
            and (len(solutions[key]['xor']) > 0)
            and (len(solutions[key]['nand']) > 0)
            and (len(solutions[key]['nor']) > 0)
            and (len(solutions[key]['xnor']) > 0)):
            
            num_valid_solutions += 1
            print_valid_solution(solutions[key], key)
            
    print('{0} valid solutions (out of {1} tested deltas).'.format(num_valid_solutions, len(possible_deltas)))
    
    with open('solutions.json', 'w') as f:
        f.write(json.dumps(solutions, indent=4))
    
    print('All solutions saved to "solutions.json".')
    
if __name__ == '__main__':
    main()
