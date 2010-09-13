import re
s=lambda n,l:0if n==1 else n in l or s(sum(int(a)**2for a in `n`),l+[n])
n=input()
print['happy','sad'][s(n,[])],'non-'*bool(re.match(r'1?$|(11+?)\1+$','1'*n))+'prime'
