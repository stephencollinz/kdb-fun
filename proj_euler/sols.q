.euler.p1:{sum g distinct where sum not (g:1+til[x-1]) mod/: 3 5}[1000];

.euler.p2:{x,sum -2#x}/[{sum[-2#x]<4e6};1 1];
.euler.p2:sum .euler.p2 where not .euler.p2 mod 2;


.euler.p3:{where not x mod til ceiling sqrt x} 600851475143;
/.euler.p3 where {1=count where not x mod til ceiling sqrt x} each .euler.p3;

.euler.p4:.euler.p4 max where {[s] reverse[s]~s:string s} each .euler.p4:asc (*) .' (900+til 100) cross 900+til 100;
.euler.p6:{xexp[sum 1+til x;2] - sum xexp[1+til x;2]} 100;
/.euler.p7:{[n] n+1}/[{[n]if[{1=count where not x mod til 1+floor sqrt x} n;m+:1];not m~10001};2];
.euler.p8:prd .euler.p8 first idesc (prd') .euler.p8:"J"$''13#'(-1 rotate)\[raze read0 `:p8.txt];
/.euler.p10:sum r where {1=count where not x mod til 1+floor sqrt x} each r:1+til "i"$2e6;
.euler.p11.pts:til[20] cross til[20]
.euler.p11.grid:get each read0 `:p11.txt
.euler.p11.steps:((0 0;0 1;0 2;0 3);(0 0;0 -1;0 -2;0 -3);(0 0;1 0;2 0;3 0);(0 0;-1 0;-2 0;-3 0);(0 0;1 1;2 2;3 3);(0 0;-1 -1;-2 -2;-3 -3);(0 0;1 -1;2 -2;3 -3);(0 0;-1 1;-2 2;-3 3))
.euler.p11.res:max raze {[pt] {prd .[.euler.p11.grid;] each x} each pt+/:/:.euler.p11.steps} each .euler.p11.pts;

.euler.p13.l:reverse sum each flip "J"$''read0 `:p13.txt
.euler.p13.r:52#0
/{[k] a:reverse 10 vs .euler.p13.l[k];@[`r;k+til count[a];+;a]} each til count .euler.p13.l;
/{[k] if[not .euler.p13.r[k];:()];@[`.euler.p13.r;k+1;{[x;k] x+.euler.p13.r[k] div 10}[;k]];@[`.euler.p13.r;k;mod[;10]]} each til count .euler.p13.l;
/10#reverse .euler.p13.r;


/r:{{[n] show n;(x[0]+1;x[1],next_num[x[1]];x[2])}/[{if[1e6=count whats_done;:0b];if[c:1=last[x[1]];d[x[2]]:count x[1]];not c};(1;n;n)]}
/5 5 3 7 3 7 6 2 3 0


.euler.p12.next_tri:{(x[0]+1;x[0]+x[1]+1)};

.euler.p12.num_factors:{t:where not x mod til 1+floor sqrt x;$[x=last[t]*last[t];(count[t]*2)-1;count[t]*2]};

.euler.p12.next_tri/[{not .euler.p12.num_factors[x[1]]>500};(1;1)];
d:()!();
next_collatz:{
 if[(last x[0]) in key[d];:(x[0];d[last x[0]]-1;1b)];

 t:"j"$$[not mod[last x[0];2];(last x[0])%2;1+3*last x[0]];
 /d[t]:x[1]+1;
 (x[0],t;x[1];x[2])
 };

collatz_check:{
 /if[x[2];
    /d[x 0]:]
 if[c:or[x[2];1=last[x[0]]];
    d[x 0]:x[1]+reverse 1+til count x[0]];
 not c
 }

.euler.p15.n:20;
.euler.p15.pts:til[1+.euler.p15.n] cross til[1+.euler.p15.n];
.euler.p15.d:.euler.p15.pts!count[.euler.p15.pts]#0;
.euler.p15.d[0 0]:1;

.euler.p15.mk_move:{[pt;num]
 pt0:pt+/:(0 1;1 0);
 pt0:pt0 where pt0 in\: .euler.p15.pts;
 /pt0:pt0 where not (|) ./: (-1;.euler.p15.n) in/: pt0:pt+/:(0 1;1 0);
 if[not count pt0;:()];
 @[`.euler.p15.d;;+;num] each pt0;
 @[`.euler.p15.d;pt;:;0];}
 
.euler.p15.mk_all_moves:{
 .euler.p15.mk_move .' (enlist each k),'get[`.euler.p15.d] k:where[get[`.euler.p15.d]>0];
 get[`.euler.p15.d]
 };

.euler.p15.res:max .euler.p15.mk_all_moves/[];


.euler.p16.do_one:{[dict;k]
 dict:@[dict;k+1;+;"j"$div[dict[k];10]];
 dict:@[dict;k;:;"j"$mod[dict[k];10]];
 dict};

 .euler.p16.give_next_power:{[str]
 d0:til[count g]!g:reverse 2*"J"$'' str;
 d1:.euler.p16.do_one/[d0;key d0];
 s:raze string reverse value d1;
 $[s[0]~"0";1_s;s]};

 /sum "J"$'' .euler.p16.give_next_power/[1000;enlist "1"]


.euler.p17.d5:()!();
.euler.p17.d5[(1+til 9)]:("one";"two";"three";"four";"five";"six";"seven";"eight";"nine");
.euler.p17.d5[10+1+til 9]:("eleven";"twelve";"thirteen";"fourteen";"fifteen";"sixteen";"seventeen";"eighteen";"nineteen");
.euler.p17.d5[10*1+til 9]:("ten";"twenty";"thirty";"forty";"fifty";"sixty";"seventy";"eighty";"ninety");
.euler.p17.d5[100*1+til 9]:.euler.p17.d5[1+til 9],\:"hundred";
.euler.p17.d5[1000]:"onethousand";
{t:10 1*10 vs x;.euler.p17.d5[x]:raze .euler.p17.d5[t]} each 21+til 79;
.euler.p17.get_a_num:{
 if[x in key[.euler.p17.d5];:.euler.p17.d5[x]];
 t:100 vs x;
 "and" sv .euler.p17.d5 $[1=count t;t;100 1*t]};
sum count each .euler.p17.get_a_num each 1+til 1000;


.euler.p19.dts0:.euler.p19.dts where 1=mod[;7] each .euler.p19.dts:1901.01.01+til 2000.12.31-1901.01.01;
.euler.p19.res:count where 1=.euler.p19.dts0.dd;


.euler.p21.sum_of_proper_divisors:{t:where not x mod til 1+floor sqrt x;sum t,"j"$x%1_t};
.euler.p21.s;()
{.euler.p21.s,:enlist (x;.euler.p21.sum_of_proper_divisors[x])} each 1+til 10000;
.euler.p21.s0:.euler.p21.s where (reverse each .euler.p21.s) in\: .euler.p21.s;
sum (.euler.p21.s0 where not (~) .' .euler.p21.s0)[;0];

euler.p22.t:asc "\",\"" vs -1_1_"c"$read1 `:0022_names.txt
euler.p22.res:sum {[n] (n+1)*sum 1+.Q.A?t[n]} each til count euler.p22.t;