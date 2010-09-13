l=n=input()
while l>4:l=sum(int(i)**2for i in str(l))
print['sad','happy'][l==1and str(n)!=1],
print['non-',''][n!=1 and sum(n%i==0for i in range(1,n))<2]+"prime"
