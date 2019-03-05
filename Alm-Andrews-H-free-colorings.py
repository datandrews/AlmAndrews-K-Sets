import itertools

def has_K4(A,m):
    # m is the modulus
    # assumes A is symmetric, i.e., x in A --> -x mod m in A
    for a,b,c in itertools.combinations(A,3):
        if (a-b)%m in A and (b-c)%m in A and (a-c)%m in A:
            return True
    return False

def has_K3_3(A,m):
    # m is the modulus
    # assumes A is symmetric, i.e., x in A --> -x mod m in A
    for a,b,c in itertools.combinations(A,3):
        for x,y,z in itertools.combinations(A,3):
            if len({a,b,c} & {x,y,z}) == 0:
                if (a-x)%m in A and (a-y)%m in A and (a-z)%m in A:
                    if (b-x)%m in A and (b-y)%m in A and (b-z)%m in A:
                        if (c-x)%m in A and (c-y)%m in A and (c-z)%m in A:
                            return True
    return False

def has_K5_2(A,m):
    # m is the modulus
    # assumes A is symmetric, i.e., x in A --> -x mod m in A
    for a,b,c,d,e in itertools.combinations(A,5):
        for x,y in itertools.combinations(A,2):
            if len({a,b,c,d,e} & {x,y}) == 0:
                if (a-x)%m in A and (a-y)%m in A:
                    if (b-x)%m in A and (b-y)%m in A:
                        if (c-x)%m in A and (c-y)%m in A:
                            if (d-x)%m in A and (d-y)%m in A:
                                if (e-x)%m in A and (e-y)%m in A:
                                    return True
    return False

Quad_res_mod_17 = {pow(x,2,17) for x in range(1,17)} # the quadratic residues mod 17

if has_K4(Quad_res_mod_17, 17) or has_K3_3(Quad_res_mod_17, 17) or has_K5_2(Quad_res_mod_17, 17):
    print("Failure: found a monochromatic subgraph.")
else:
    print("Success: no bad monochromatic subgraphs found.")
