sub h{my$s;$s+=$_**2for split//,pop;($s-4)?($s-1)?&h($s):1:0}$a=pop;
print h($a)?happy:sad,$",(1x$a)=~/^1?$|^(11+?)\1+$/&&"non-",prime
