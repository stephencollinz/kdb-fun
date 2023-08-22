.aoc.2020.p1:prd .aoc.2020.x mod[;200] where 2020=sum each .aoc.2020.x cross .aoc.2020.x:"I"$'read0 `:day1.txt;
/prd .aoc.2020.x distinct mod[;200] where 2020=sum each .aoc.2020.g:.aoc.2020.x cross .aoc.2020.x cross .aoc.2020.x;


.aoc.2020.p2.x:read0 `:day2.txt;
.aoc.2020.p2.checker:{[str]
 spl:" " vs str;
 rng:"I"$'vs["-";spl[0]];
 lttr:spl[1][0];
 cnt:count group[spl[2]][lttr];
 /lttr:spl[1][0];
 cnt within rng
 };

count where .aoc.2020.p2.checker each .aoc.2020.p2.x;

.aoc.2020.p2.checker2:{[str]
 spl:" " vs str;
 rng:"I"$'vs["-";spl[0]];
 lttr:spl[1][0];
 /cnt:count group[spl[2]][lttr];
 /lttr:spl[1][0];
 1=count where lttr=spl[2]rng-1
 /cnt within rng
 };
/1=count where lttr=spl[2]rng-1

count where .aoc.2020.p2.checker2 each .aoc.2020.p2.x;

.aoc.2020.p3.x:read0 `:day3.txt
count where "#"=.[1000#'.aoc.2020.p3.x;] each  {x+ 1 3}\[322;0 0];

.aoc.2020.p3.count_trees:{[stp] 
 stps:{[x;y] x+y}[;stp]\[{not x[0]=count[.aoc.2020.p3.x]-1};0 0]; 
 count where "#"=.[(1+max stps[;1])#'.aoc.2020.p3.x;] each  stps};

/prd .aoc.2020.p3.count_trees @' (1 1;1 3;1 5;1 7;2 1)

.aoc.2020.p4.rqd_fields:`byr`iyr`eyr`hgt`hcl`ecl`pid;

{[str] all .aoc.2020.p4.rqd_fields in\: key (!/) "S: " 0:str} each .aoc.2020.p4.x:"  " vs " " sv read0 `:day4.txt;

.aoc.2020.p4.checker:{[str]
 dict:(!/) "S: " 0:str;
 byr:$["I";dict[`byr]] within 1920 2002;
 iyr:$["I";dict[`iyr]] within 2010 2020;
 eyr:$["I";dict[`eyr]] within 2020 2030;
 hgt:$[(h:dict[`hgt]) like "*cm";$["I";-2_h] within 150 193;$["I";-2_h] within 59 76];
 hcl:dict[`hcl] like "#",raze 6#enlist "[0-9,a-f]";
 ecl:$[`;dict[`ecl]] in `amb`blu`brn`gry`grn`hzl`oth;
 pid:dict[`pid] like raze 9#enlist "[0-9]";
 all(byr;iyr;eyr;hgt;hcl;ecl;pid)}

count where .aoc.2020.p4.checker each .aoc.2020.p4.x;

.aoc.2020.p5.L0:"FB";
.aoc.2020.p5.L1:"LR";

.aoc.2020.p5.x:read0 `:day5.txt;
max res:{[str] row:2 sv .aoc.2020.p5.L0?7#str;col:2 sv .aoc.2020.p5.L1?7_str;col+8*row} each .aoc.2020.p5.x;
except[(min[res]+til[1+max[res]-min[res]]);res];

sum count each distinct each raze each (0,where ""~/:.aoc.2020.p6.t) cut .aoc.2020.p6.t:read0 `:day6.txt;
sum count each (inter/) each " " vs' "  " vs " " sv read0 `:day6.txt;

.aoc.2020.p7.x:read0 `:day7.txt;
.aoc.2020.p7.d:()!();
.aoc.2020.p7.all_bags:{[str] spl:" bags contain" vs str;`$spl[0]} each .aoc.2020.p7.x;
{[str] spl:" bags contain" vs str;.aoc.2020.p7.d[`$spl[0]]:.aoc.2020.p7.all_bags where spl[1] like/: "*",/:string[.aoc.2020.p7.all_bags],\:"*"} each .aoc.2020.p7.x;
count where not 0=count each {[clr] {distinct raze .aoc.2020.p7.d raze x}/[{not or[not count x;$[`;"shiny gold"] in x]};clr]} each except[.aoc.2020.p7.all_bags;`$"shiny gold"];

.aoc.2020.p7.init:first .aoc.2020.p7.x where (first each vs[" bags contain";] each .aoc.2020.p7.x) like\: "shiny gold";
.aoc.2020.p7.get_sub_bags:{[n;bag]
 if[bag~`other;:enlist (n;bag)];
 str:first .aoc.2020.p7.x where (first each vs[" bags contain";] each .aoc.2020.p7.x) like\: string bag;
 spl:vs[" bags contain ";str];
 s:first each vs[" bag";] each vs[", ";spl[1]];
 .aoc.2020.p7.total+:n;
 nums:n*"I"$'first each vs[" ";] each s;
 bags:`$sv[" ";] each 1_'vs[" ";] each s;
 nums,'bags
 };

.aoc.2020.p7.f:raze .aoc.2020.p7.get_sub_bags ./:;
.aoc.2020.p7.total:-1; / start on -1 as we don't count shiny gold bag itself
.aoc.2020.p7.f/[enlist (1;`$"shiny gold")];
.aoc.2020.p8.x:read0 `:day8.txt;
.aoc.2020.p8.acc_total:.aoc.2020.p8.pos:0i;
.aoc.2020.p8.done:();
.aoc.2020.p8.f:{[n;txt]
 str:txt n;
 .aoc.2020.p8.done,:.aoc.2020.p8.pos;
 spl:vs[" ";str];
 act:spl[0];
 stp:spl[1];
 /'break
 @[` sv `.aoc.2020.p8,`$act;"I"$stp];
 /.aoc.2020.p8.done,:
 .aoc.2020.p8.pos
 };

.aoc.2020.p8.f0:{[n]
 .aoc.2020.p8.acc_total:.aoc.2020.p8.pos:0i;
 .aoc.2020.p8.done:();
 .aoc.2020.p8.f[;.aoc.2020.p8.switch n]/[{not or[x~count .aoc.2020.p8.x;x in .aoc.2020.p8.done]};0]};

.aoc.2020.p8.acc:{[n] .aoc.2020.p8.acc_total+:n;.aoc.2020.p8.pos+:1};
.aoc.2020.p8.jmp:{[n] .aoc.2020.p8.pos+:n};
.aoc.2020.p8.nop:{[n] .aoc.2020.p8.pos+:1};

.aoc.2020.p8.switch:{[n] xx:.aoc.2020.p8.x;xx[n]:xx[n]:$[xx[n] like "*jmp*";ssr[xx[n];"jmp";"nop"];xx[n] like "*nop*";ssr[xx[n];"nop";"jmp"];xx[n]];xx};

/group .aoc.2020.p8.f0 each til 636;

.aoc.2020.p9.x:"I"$'read0 `:day9.txt;
.aoc.2020.p9.check:{[n;m] l:m#n _.aoc.2020.p9.x;.aoc.2020.p9.x[n+m] in raze (1+til[m])_'l+\:l}[;25];
.aoc.2020.p9.x 25+{x+1}/[.aoc.2020.p9.check;0];

count each group deltas asc "I"$'read0 `:day10.txt;
.aoc.2020.p10.x:asc "J"$'read0 `:day10.txt
.aoc.2020.p10.d:((enlist 0)!enlist 1),.aoc.2020.p10.x!count[.aoc.2020.p10.x]#0;

.aoc.2020.p10.do_update:{[k]
 if[k~max key .aoc.2020.p10.d;:()];
 @[`d;inter[key .aoc.2020.p10.d;k+1+til 3];+;.aoc.2020.p10.d[k]];
 @[`d;k;:;0];
 }
.aoc.2020.p11.x:read0 `:day11.txt;
.aoc.2020.p11.pts:til[count .aoc.2020.p11.x]cross til[count flip .aoc.2020.p11.x];
.aoc.2020.p11.stps:(-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1);
.aoc.2020.p11.d:".L#"!(`.aoc.2020.p11.flr`.aoc.2020.p11.free`.aoc.2020.p11.occupied);
.aoc.2020.p11.free:{[pt;grid] $["#" in .[grid;] each pt+/:.aoc.2020.p11.stps;"L";"#"]}
.aoc.2020.p11.occupied:{[pt;grid] $[4<=count where "#"~/:.[grid;] each pt+/:.aoc.2020.p11.stps;"L";"#"]}
.aoc.2020.p11.flr:{[pt;grid] "."}

.aoc.2020.p11.do_update:{[grid] 
 .aoc.2020.p11.new_grid::grid;
  {[pt;grid] .[`.aoc.2020.p11.new_grid;pt;:;.[.aoc.2020.p11.d .[grid;pt];(pt;grid)]]}[;grid] each .aoc.2020.p11.pts;
  .aoc.2020.p11.new_grid};

.aoc.2020.p11.get_nearest_pts:{[g;p] .[g;] each {[p;s;g] {x+y}[;s]/[{[grid;pt].[grid;pt]~"."}[g;];p+s]}[p;;g] each .aoc.2020.p11.stps};
.aoc.2020.p11.d0:".L#"!(`.aoc.2020.p11.flr0`.aoc.2020.p11.free0`.aoc.2020.p11.occupied0);
.aoc.2020.p11.free0:{[pt;grid] $["#" in .aoc.2020.p11.get_nearest_pts[grid;pt];"L";"#"]};
.aoc.2020.p11.occupied0:{[pt;grid] $[5<=count where "#"~/:.aoc.2020.p11.get_nearest_pts[grid;pt];"L";"#"]};
.aoc.2020.p11.flr0:{[pt;grid] "."}


.aoc.2020.p11.do_update0:{[grid] 
 .aoc.2020.p11.new_grid::grid;
  {[pt;grid] .[`.aoc.2020.p11.new_grid;pt;:;.[.aoc.2020.p11.d0 .[grid;pt];(pt;grid)]]}[;grid] each .aoc.2020.p11.pts;
  .aoc.2020.p11.new_grid};

/count where "#"~/:raze .aoc.2020.p11.do_update0/[.aoc.2020.p11.x]
.aoc.2020.p12.x:read0 `:day12.txt;
.aoc.2020.p12.all_dirs:"ESWN"!(0 1;-1 0;0 -1;1 0);
.aoc.2020.p12.state:`dir`mn`me!(0 1;0;0);
.aoc.2020.p12.turn:{[str] 
 d:"RL"!1 -1;
 p:div[d[str[0]]*"I"$1_str;90]+get[.aoc.2020.p12.all_dirs]?.aoc.2020.p12.state[`dir];
 .aoc.2020.p12.state[`dir]:get[.aoc.2020.p12.all_dirs] mod[p;4]};

.aoc.2020.p12.move:{[str] 
 dir:$[str[0]~"F";.aoc.2020.p12.state[`dir];.aoc.2020.p12.all_dirs[str[0]]];
 .aoc.2020.p12.state[`mn`me]+:dir*"I"$1_str};
 /state[`dir]:all_dirs div[d[str[0]]"I"$1_str;90]+all_dirs?state[`dir]};

.aoc.2020.p12.do_instr:{[str] fd:"ESNWFRL"!(5#`.aoc.2020.p12.move),2#`.aoc.2020.p12.turn;@[fd[str[0]];str]};

.aoc.2020.p12.state0:`wp`dir`mn`me!(1 10;0 1;0;0);

.aoc.2020.p12.move0:{[str]  
 $[str[0]~"F";
    .aoc.2020.p12.state0[`mn`me]+:.aoc.2020.p12.state0[`wp]*"I"$1_str;
    .aoc.2020.p12.state0[`wp]+:.aoc.2020.p12.all_dirs[str[0]]*"I"$1_str];};

.aoc.2020.p12.rotate0:{[str] 
 d:"RL"!(-1 1;1 -1);
 .aoc.2020.p12.state0[`wp]:{y[z 0]*reverse x}[;d;str]/[div["J"$1_str;90];.aoc.2020.p12.state0[`wp]];};

.aoc.2020.p12.do_instr0:{[str] fd:"ESNWFRL"!(5#`.aoc.2020.p12.move0),2#`.aoc.2020.p12.rotate0;@[fd[str[0]];str]};


