
def collect(path):
    result_files = []
    for root, _, files in os.walk(path):
        for f in files:
            result_files.append(os.path.join(root, f))
    return result_files

def ascii(chrs):
    return "".join(chr(c) for c in chrs)

import os

def printsystem(cmd):
    print(cmd)
    os.system(cmd)

def implies(a, b):
    return not a or b

def gcd(x, y):
    if y == 0:
        return x
    else:
        return gcd(y, x % y)

def invmod(x, p):
    orig_p = p
    inv1 = 1
    inv2 = 0
    while p != 1:
        inv1, inv2 = inv2, inv1 - inv2 * (x // p)
        x, p = p, x % p

    return inv2 % orig_p


def invmod2(x, p):
    orig_p = p
    inv1 = 1
    inv2 = 0
    while p != 1:
        inv1, inv2 = inv2, inv1 - inv2 * (x // p)
        x, p = p, x % p

    return inv2, inv1
