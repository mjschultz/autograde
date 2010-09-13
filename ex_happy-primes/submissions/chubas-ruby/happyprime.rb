h={};s=->x{y=x.scan(/./).reduce(0){|a,i|a+i.to_i**2};y==1&&'happy'||h[y]||(h[y]='sad';s[y.to_s])}
p=$*[0];puts"#{s[p]} #{'non-'if('1'*p.to_i)=~/^1?$|^(11+?)\1+$/}prime"
