x=input()
def p(x):
 if x==1 or 1 in [1 for i in xrange(2,x/2+1) if x%i==0]: return True
def h(x):
 l=[]
 while x not in l:
  l.append(x)
  x=sum([int(i)**2 for i in str(x)])
 if 1 in l: return True
if h(x):print'happy',
elif not h(x):print'sad',
if p(x):print'non-prime'
elif not p(x):print'prime'
