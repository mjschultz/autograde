n=input()
s='prime'
for i in range(2,n):
    if n%i==0: 
        s='non-'+s
        break
f=list(str(n))
g=set()
while n!=1:
    n=sum([int(z)**2 for z in f])
    if n in g:
        s='sad '+s
        break
    else:
        f=list(str(n))
        g.add(n)
else:
    s='happy '+s
print s
