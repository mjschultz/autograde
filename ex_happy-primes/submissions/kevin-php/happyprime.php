<?$t=$argv[1];for($z=$t-1,$p=1;$z&&++$p<$t;)$z=$t%$p;$f=array(1);while(!in_array($t,$f,1)){$f[]=$t;$t=array_reduce(str_split($t),function($v,$c){return $v+=$c*$c;});}print($t<2?"happy ":"sad ").(!$z?"non-":"")."prime";?>
