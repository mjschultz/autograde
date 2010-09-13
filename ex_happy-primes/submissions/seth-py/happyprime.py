import re,sys
def ge(z):
 while z!=1:z=sum((int(a)**2 for a in str(z)));yield z
def h(n):
 l=[];g=ge(n)
 while True:
  try:z=g.next()
  except:return True
  if z in l:return False
  l.append(z)
def p(n):return re.match(r'^1?$|^(11+?)\1+$','1'*n)is None
n=int(sys.argv[1])
print "%s %sprime"%(('sad','happy')[h(n)],('non-','')[p(n)])
