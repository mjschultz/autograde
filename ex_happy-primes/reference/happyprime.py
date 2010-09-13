import sys
n,j=int(sys.argv[1]),'prime'
k='non-'+j
def h(n):
 s=set()
 while n!=1:
  n=sum(int(a)**2 for a in str(n))
  if n in s:return'sad'
  s.add(n)
 return'happy'
def p(n):
 if n==1:return k
 for x in xrange(2,int(n**0.5)+1):
  if n%x==0:return k
 return j
print h(n),p(n)
