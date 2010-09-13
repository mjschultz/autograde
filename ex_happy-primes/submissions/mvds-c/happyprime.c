h(c,C,r,p){for(;C>1&&C%++p;);for(;c;c/=10)r+=c%10*(c%10);r&~5?h(r,C,0,1):printf(
"%s %sprime",r-1?"sad":"happy",p>=C&C>1?"":"non-");}main(c){h(c,c,0,scanf("%d",&c));}
