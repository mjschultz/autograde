import java.util.*;class H{public static void main(String[]a){int n=new Integer(a[0]),p=n,m=0,d;Set s=new HashSet();for(;n!=1&s.add(n);n=m,m=0)for(;n>0;d=n%10,m+=d*d,n/=10);System.out.printf("%s %sprime",n==1?"happy":"sad",new String(new char[p]).matches(".?|(..+?)\\1+")?"non-":"");}}