A=[5 3 1]

B=[-1 2 0]

dot(A,B)

magA=sqrt(sum(A.^2))

magB=sqrt(sum(B.^2))

acos(dot(A,B)/(magA*magB))

rad2deg(acos(dot(A,B)/(magA*magB)))
