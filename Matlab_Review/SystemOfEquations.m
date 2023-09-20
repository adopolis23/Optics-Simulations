syms x y

eq1 = 3*x + 4*y == 10
eq2 = x - 2*y == 2

[A, B] = equationsToMatrix([eq1, eq2], [x, y])

X = linsolve(A, B)