#include<iostream>
#define w while
int m,n,i,j=0,t=10;int main(){w(std::cin>>n){m=n;w(n>1){i=0;do i+=n%t*(n%t);w(n/=t);n=n*n+i;n=++j&0xFFFF?n:0;}m=m-1?m:4;i=m;w(m%--i);std::cout<<(n?"happy":"sad")<<(i-1?" non-":" ")<<"prime\n";}}
