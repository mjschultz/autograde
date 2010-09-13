l=n=input()
while 4<l : l=sum(int(i)**2for i in str(l))
print['sad','happy'][l<2],'non-prime'[4*all(n%i for i in range(2,n))*(n>1):]
