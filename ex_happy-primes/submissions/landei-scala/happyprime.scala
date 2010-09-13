object H{def main(a:Array[String]){var s=Set(0)
val n=a(0)toInt
def r(m:Int):String={val k=""+m map(c=>c*(c-96)+2304)sum;if(k<2)"happy"else if(s(k))"sad"else{s+=k;r(k)}}
printf("%s %sprime",r(n),if(n<2|(2 to n-1 exists(n%_==0)))"non-"else"")}}
