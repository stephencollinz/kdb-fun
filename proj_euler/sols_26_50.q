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