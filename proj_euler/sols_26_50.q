
.euler.p30.s:2+til 1000000;
sum .euler.p30.s where {x=sum xexp[;5] "J"$'string[x]} each .euler.p30.s;

.euler.p36.is_palindrome:{reverse[x]~x};
.euler.p36.s:();


.euler.p37.is_palin_both_bases:{[n]
 if[not .euler.p36.is_palindrome[string n];:()]; 
 if[.euler.p36.is_palindrome[raze string 2 vs n];.euler.p36.s,:n]} 
 
/.euler.p36.is_palin_both_bases each 1+til 999999;
/sum .euler.p36.s;
.euler.p37.is_prime:{if[x in 1 2;:0b];not count 1_where not x mod til 1+floor sqrt x};
/.euler.p37.k:.euler.p37.g where is_prime each .euler.p47.g:til 1000000
/sum (4_.euler.p37.k) where {[t] all ("J"$(neg[c],c:1_til count[s])#\:s:string t) in\: k} each 4_.euler.p37.k


.euler.p35.is_prime:{if[x in 0 1;:0b];show x;not count 1_where not x mod til 1+floor sqrt x};
/.euler.p35.k:.euler.p35.g where .euler.p35.is_prime each .euler.p35.g:til 1000000
/count where {t:"J"$(1 rotate)\[string x]; all t in\: .euler.p35.k} each .euler.p35.k
 
/.euler.p50.k:.euler.p35.g where .euler.p50.is_prime each .euler.p50.g:til 1000000;
/.euler.p50.do_a_step:{index:x[0];sm:x[1];run:x[2];(index;sm+.euler.p50.k[index+run];run+1)};
/.euler.p50.s:.euler.p50.s0:0;
/{[n] show (n;.euler.p50.s;.euler.p50.s0);r0:.euler.p50.do_a_step\[{not x[1]>max[.euler.p50.k]};(n;0;0)];if[.euler.p50.s0<m0:r0[;1]?m:max r0[;1] where r0[;1] in\: .euler.p50.k;set[`.euler.p50.s0;m0];set[`.euler.p50.s;m]]} each til count .euler.p50.k;

.euler.p25.cut1:{x _ x?y} / this removes element 
.euler.p25.child_anagrams:{[str;substr]
 if[count[substr]~count[str];:enlist substr]; / if we're done, we're done
 substr,/:.euler.p25.cut1/[str;substr]};

.euler.p25.get_all_anagrams:{[str]
 distinct (raze .euler.p25.child_anagrams[str;] each)/[str]};

.euler.p29.stringsum:{[dict;k]
 dict:@[dict;k+1;+;"j"$div[dict[k];10]];
 dict:@[dict;k;:;"j"$mod[dict[k];10]];
 dict};

.euler.p29.give_next_power:{[str;power]
 d0:til[count g]!g:reverse power*"J"$'' str;
 d1:.euler.p29.stringsum/[d0;key d0];
 s:raze string reverse value d1;
 $[s[0]~"0";1_s;s]};
//.euler.p28.
//{[n] 1+sum {(4*x*x)-6*(x-1)} each 3+2*til div[n;2]} 1001

/.euler.p27.b:.euler.p27.a where .euler.p35.is_prime each .euler.p27.a:til 1001;
/.euler.p27.c:(-999+til 1999) cross .euler.p27.b;
/prd .euler.p27.c first idesc .euler.p27.r:{[a;b] show (a;b);{x+1}/[{[a;b;c].euler.p35.is_prime[(c*c)+(a*c)+b]}[a;b];0]} ./: .euler.p27.c;
.euler.p31.L:1 2 5 10 20 50 100 200;
.euler.p31.L0:{[coin] 0,{[x;n] x+n}[;coin]\[{[x;n]200>=x+n}[;coin];coin]} each .euler.p31.L;
.euler.p31.t:0;
.euler.p31.cross_coin:{[x;y] a:sum each cross[x;y]; t+:count where a=200;a where a<200};
/.euler.p41.cross_coin/[L0]


count .euler.p41.s:.euler.p25.get_all_anagrams raze string 1+til 7;
.euler.p41.s1:.euler.p41.s where not (any ') .euler.p41.s like/:\: "*",/:string 2*til 5;
.euler.p41.s2:asc get each .euler.p41.s1;
.euler.p41.s3:.euler.p41.s2 where not not .euler.p41.s2 mod 3
.euler.p41.s4:string reverse .euler.p41.s3;
/{x+1}/[{not .euler.p35.is_prime get .euler.p41.s4[x]};0];

.euler.p43.check_substr_div:{[x;n] mod[get x[(n+1;n+2;n+3)];L[n]]};
.euler.p43.L:2 3 5 7 11 13 17;
/.euler.p43c0:.euler.p43c where {x[3] in "02468"} each .euler.p43c;
/.euler.p43c:.euler.p25.get_all_anagrams raze string til 10;
/sum "J"$' .euler.p43c0 where {[s] not max .euler.p41.check_substr_div[s;] each til 7} each .euler.p41.c0;

/{{[s;t] 
/ s:"(",s;s:ssr[s;t[1];t[1],"*"];
/ ssr[s;t[0];t[0],")="]}[t;] 
/ each t0 where {(>) . ?[x;] y}[c;] each t0} first c
.euler.p32.L:(1 0;2 0;2 1;3 0;3 1;3 2;4 0;4 1;4 2;4 3;5 0;5 1;5 2;5 3;5 4);
/.euler.p32.c:.euler.p25.get_all_anagrams raze string 1+til 9;
.euler.p32.add_ops:{[str;l] 
    str:"(",str;
    str:ssr[str;str[1+l 1];str[1+l 1],"*"];
    ssr[str;str[2+l 0];str[2+l 0],")="]};
    
.euler.p32.prods:();
.euler.p32.check_for_eq:{[str]
 c0:where get each d:.euler.p32.add_ops[str;] each .euler.p32.L;
 if[not count c0;:()];
 .euler.p32.prods,:"J"$last each vs'["=";d c-];
 }

/{ .euler.p32.n+:1;show .euler.p32.n;.euler.p32.check_for_eq c x} each til count .euler.p32.c;
/count distinct .euler.p32.prods;

prime_factors:{
 num:x[0];
 fact:x[1];
 num_facts:x[2]
 m:not mod[num;fact];
 $[m;("j"$num%fact;2;distinct x[2],fact);(num;fact+1;x[2])]
  };

count_prime_factors:{[n]
 s::();
 prime_factors/[{not x[0]=1};(n;2)];
 count s
 };

count_distinct_prime_factors:{[n]
 show n;
 s::();
 prime_factors/[{not x[0]=1};(n;2)];
 count distinct s
 };
/.euler.p41.s:.euler.p41.c where .euler.p35.is_prime each .euler.p41.c:1000+til 9000;
/.euler.p41.r:raze each {[t] t0:"J"$'t0 where (&') .' (asc string t)~/:/:(asc') each t0:string euler.p41.s g where 2=count each g:group abs (t)-euler.p41.s;$[count t0;t,t0;t0]} each euler.p41.s
/.euler.p41.r where not 0=count each .euler.p41.r;
/.euler.p41.s:.euler.p41.c where .euler.p35.is_prime each .euler.p41.c:1000+til 9000;
.euler.p42.s:(sum') 1+.Q.A?/:"\",\"" vs -1_1_"c"$read1 `:0042_words.txt;
.euler.p42.tri_nums:sums 1+til 20;
count .euler.p42.s where .euler.p42.s in\: .euler.p42.tri_nums;


.euler.p45.tris:.euler.p45.pents:.euler.p45.hexs:();
.euler.p45.add_t_p_h:{[n] .euler.p45.tris,:"j"$n*(n+1)%2;.euler.p45.pents,:"j"$n*(-1+3*n)%2;.euler.p45.hexs,:n*-1+2*n;n+1};
/.euler.p45.add_t_p_h/[{show x;not 3=count inter/[(.euler.p45.tris;.euler.p45.pents;.euler.p45.hexs)]};1]

.euler.p33.digit_fractions:{[pair]
 str:string pair;
 if[not count s:str[0] where (in\:) . str;:0b];
 if["0" in s;:0b];
 if[not (&/) 1= count each s0:ssr[;s;""]@/: str;:0b];
 if[1<d0:(%). pair;:0b];
 d0=(%).(get each s0)};

.euler.p33.c:.euler.p33.a cross .euler.p33.a:10+til 90;
.euler.p33.r:.euler.p33.c where .euler.p33.digit_fractions each .euler.p33.c;
reciprocal (%) . prd each flip  .euler.p33.r;

.euler.p47.factors:{t:where not x mod til 1+floor sqrt x;distinct asc "j"$t,x%t};
/.euler.p47.p:asc .euler.p47.g where .euler.p35.is_prime each .euler.p47.g:til 300000;
/.euler.p47.r0:{[n] show n; count inter[.euler.p47.factors[n];.euler.p47.p]} each 2+til 300000;
/first 2+ss[;"1111"] raze string 4=.euler.p47.r0