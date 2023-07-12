cut1:{x _ x?y} / this removes element 
child_anagrams:{[str;substr]
 if[count[substr]~count[str];:enlist substr]; / if we're done, we're done
 substr,/:cut1/[str;substr]};

get_all_anagrams:{[str]
 distinct (raze child_anagrams[str;] each)/[str]}