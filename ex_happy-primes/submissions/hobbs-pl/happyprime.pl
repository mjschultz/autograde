sub h{$_==1&& happy||$s{$_}++&& sad||do{$m=0;$m+=$_**2for split//;$_=$m;&h}}$n=$_=pop;die h,$",(1x$n)=~/^1?$|^(11+?)\1+$/&&"non-","prime\n"
