import numpy as np
import sys
import itertools

if __name__=='__main__':
    num = sys.argv[1]
    num = float(num)
    digits = int(np.log2(num)) + 1
    
    ans = num*2.0
    for prod in itertools.combinations_with_replacement([1,2,3,5], digits):
        tmp = np.product(prod)
        if tmp > num and (tmp % 2 == 0):
            if tmp < ans:
                ans = tmp
                best_prod = prod

    if float(num)/float(ans) < 0.8:
        ans = 1.0
        for prod in itertools.combinations_with_replacement([1,2,3,5], digits):
            tmp = np.product(prod)
            if tmp < num and (tmp % 2 == 0):
                if tmp > ans:
                    ans = tmp
                    best_prod = prod  

    print ans
    print best_prod

