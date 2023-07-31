// Day 1
max sum each group[d][0N] cut d:"J"$read0 `:day1.txt; / shouldn't use group 
sum -3#asc sum each group[d][0N] cut d:"J"$read0 `:day1.txt;


// Day 2
d:(asc distinct r:read0 `:day2.txt)! 4 8 3 1 5 9 7 2 6;
sum d*count each group r;


// Day 3
sum 1+.Q.an?{[inp] c:"i"$count[inp]%2; distinct (inter) . #[;inp]'[(c;neg c)]} each read0 `:day3.txt;
sum 1+.Q.an?{[inp] distinct inter/[inp]} each 3 cut read0`:day3_2.txt;

// Day 4
count where not not {[inp] z:raze "I"$vs["-";] each csv vs inp;a:z[0] + til 1+z[1] - z[0];b:z[2] + til 1+z[3] - z[2];count inter[a;b]} each read0 `:day4.txt;
count where {[inp] z:raze "I"$vs["-";] each csv vs inp;or[and[z[0]>=z[2];z[1]<=z[2]];and[z[0]<=z[2];z[1]>=z[2]]]} each read0 `:day4.txt;

// Day 5
x:read0 `:day5.txt
d:flip (s:first where x like\: " 1*")#x
r:trim each d {x,max[x]+4}/[{4<count[d]-last[x]};1]
moves:{[inp] "I"$vs[" ";inp] 1 3 5} each (s+2) _ x
{[inp] c:r[inp[1]-1] til inp[0]; @[`r;inp[1]-1;{y _x}; inp 0];@[`r;inp[2]-1;{y,x};reverse c];} each moves;first each r;
{[inp] c:r[inp[1]-1] til inp[0]; @[`r;inp[1]-1;{y _x}; inp 0];@[`r;inp[2]-1;{y,x};c];} each moves;first each r;

// Day 6
x:first read0 `:day6.txt;
4+first where {[inp]4=count distinct inp} each xx:x til[count[x]-1]+\:til 4;
14+first where {[inp]14=count distinct inp} each xx:x til[count[x]-1]+\:til 14;

// Day 7
x:read0 `:day7.txt
x:1_x;
dir_to_subdir:()!();
dir_to_directfilesum:()!();

our_pwd:`$":";

move_up_dir:{[cmd] set[`our_pwd;` sv -1_` vs our_pwd];set[`x;1_x]};
move_down_dir:{[cmd] set[`our_pwd;` sv our_pwd,`$last[vs[" ";cmd]]];set[`x;1_x]};
list_dir:{[]
    len:count[x]^(where x like\: "$*")[1];
    ls_output:x 1+til len-1;
    filesum:sum "I"$first each vs[" ";] each ls_output where not ls_output like\: "dir *";
    subdirs:4_'ls_output where ls_output like\: "dir *";
    dir_to_subdir[our_pwd]:`$subdirs;
    dir_to_directfilesum[our_pwd]:filesum;
    set[`x;len _x];}

parse_fs:{[inp]
 if[not count inp;:inp];
 cmd:inp[0];
 $[cmd like "$ cd ..";
    move_up_dir[];
    cmd like "$ cd*";
    move_down_dir[cmd];
    list_dir[]];
 x
 }

sum_up_all_files:{[dir] 
 subdirs:` sv' dir,/:dir_to_subdir[dir];
 dir_to_directfilesum[dir]+:sum dir_to_directfilesum subdirs
  };


parse_fs/[x];
sum_up_all_files each reverse key dir_to_subdir;
sum dir_to_directfilesum where dir_to_directfilesum<=1e5;
tgt:3e7-7e7-dir_to_directfilesum[`$":"];
min dir_to_directfilesum where dir_to_directfilesum>=tgt;


// Day 8
x:("I"$')each read0 `:day8.txt
visible_trees:0;

check_visibility:{[a;b]
 r:any x[a;b]>max each (b#x[a];(b+1) _x[a];a#x[;b];(a+1) _x[;b]);
 visible_trees+:r;};

check_visibility .' cross[til count[x];til count flip x];

max_range:0;
check_range:{[a;b]
 r:(reverse b#x[a];(b+1) _x[a];reverse a#x[;b];(a+1) _x[;b]);
 s:1+(r:x[a;b]>'r)?'0b;
 c:count each r;
 range:prd c&s;
 max_range|:range;
  }

check_range .' cross[til count[x];til count flip x];

//Day 9
x:flip "S ," 0: "," sv read0 `:day9.txt;
.[`x;(::;1);"J"$];
H:T:0 0;

//Day 10

x:flip "S ," 0: "," sv read0 `:day10.txt;
.[`x;(::;1);"J"$];

addx:{cycle+:1;checkSys[];cycle+:1;checkSys[];register+:x;};
noop:{cycle+:1;checkSys[];};
checkSys:{if[20=mod[cycle;40];sysStrength+:cycle*register];};
sysStrength:cycle:0;register:1;CRT:"";
eval'[x];

checkSys:{r:mod[cycle;40];CRT,:$[r in register+til 3;"#";"."];if[not r;sysStrength+:cycle*register;CRT,:" ";];}
eval'[x];" " vs CRT;

//Day 11
x:7 cut read0 `:day11.txt;
monkey_to_items:()!();
{[inp] items:"I"$vs[",";last vs[":";x[inp;1]]];monkey_to_items[inp]:items} each til count x;
init_monkey_table:{[inp]
 y:x[inp];
 items:"J"$vs[",";last vs[":";y[1]]];
 op:last vs["=";y[2]];
 di:"I"$last vs[" ";y[3]];
 t:"I"$last vs[" ";y[4]];
 f:"I"$last vs[" ";y[5]];
 upsert[`master_table;(inp;items;op;di;t;f;0)];
 }

master_table:([monkey:`int$()] items:();operation:();divisibility:`int$();if_true:`int$();if_false:`int$();inspections:());

init_monkey_table each til count x;

move_first_item:{[inp;item]
  //show (inp;item);
  /if[not count item;:items];
  y:master_table[inp];
  old::item;
  //show inp[`operation];
  new:get y[`operation];
  //show new;
  new:div[new;3];
  //show new;
  move_to:$[not mod[new;y[`divisibility]];y[`if_true];y[`if_false]];
  //show move_to;
  .[`master_table;(inp;`items);_;0];
  .[`master_table;(move_to;`items);,;new];
  .[`master_table;(inp;`inspections);+;1];
  };
check_each_item_for_inp:{[inp]

 /y:master_table inp;
 items:master_table[inp;`items];
 //show items;
 move_first_item[inp;] each items;};

do_a_round:{[res] check_each_item_for_inp each til count x};

//do_a_round 20#`;
//exec prd inspections from select [2; >inspections] from master_table;
md:exec prd divisibility from master_table;
// Part 2
move_first_item:{[inp;item]
  y:master_table[inp];
  if[item=0w;'break];
  old::item;
  new:get y[`operation];

  move_to:$[not mod[new;y[`divisibility]];y[`if_true];y[`if_false]];
  //show move_to;
  .[`master_table;(inp;`items);_;0];
  .[`master_table;(move_to;`items);,;mod[new;md]];
  .[`master_table;(inp;`inspections);+;1];
  };

prd 2#desc exec inspections from master_table;
//Day 13
x:read0 `:day13.txt;
inds:{[inp] sum 1 2 3*"[]," ~/:\:inp} each x;


switcheroo:{[index] 
 r:"();",'enlist each (where ')1 2 3=\:inds index;
 {[x_index;inp].[`x;(x_index;inp[1]);:;inp[0]]}[index;] each r;
 };

switcheroo each til count x;
x:get each x;


//Day 25
x:read0 `:day25.txt;
d:"=-012"!-2 -1 0 1 2;
//f:{[x;y] x+:s;$[x in 3 4 5;(s::1b;x-:5);(s::0b;x)];:x};

b:reverse 5 vs sum 5 sv' d'[x];
f:{[x] x+:s;$[x in 3 4 5;(s::1b;x-:5);(s::0b;x)];:x};
d?reverse @[b;(::);f];

//Day 20
x:read0 `:day20.txt;
inds:roll_inds:til count x;
rotate_list:{[index]
 pos:roll_inds index;
 val: x[pos];
 old:pos+til 1+val;
 new:neg[val] rotate old;

 /@[`x;pos+til 1+val;:;y val rotate pos+til 1+val];
 /@[`roll_inds;pos+til 1+val;:;val rotate pos+til 1+val]
 @[`x;old;:;x new];
 @[`roll_inds;roll_inds old;:;neg[val] rotate roll_inds old];  
  };

//Day 21
d:ssr[;"/";"%"] each read0`:day21.txt;
eval_21:{[inp] res:@[get;inp;`fail];$[res~`fail;inp;""]}
//(eval_21 each)/[{[inp] not not max count each inp};d];"j"$root;

//Part B
@[`d;where d like\: "root*";ssr[;"+";"="]];
e:d except d where d like\: "humn*";
//syms:except[`$4#'e;`root];
//root_string:first d where d like\: "root*";


//res:swap_em_out/[];
g:g where 0<count each g:(eval_21 each)/[e];
gg:{[input] rr:" " sv {[inp]string @[{[inp] "j"$get inp};inp;`$inp]} each 1_input1:vs [" ";input];input1[0]," ",string @[{[inp] "j"$get inp};rr;`$rr]} each g;
//d:{[input] rr:" " sv {[inp]string @[get;inp;`$inp]} each 1_input1:vs [" ";input];input1[0]," ",string @[get;rr;`$rr]} each d;
root_string:first gg where gg like\: "root*";
 op_d:"%*+-"!"*%-+";
solver:{[str]
 split:" " vs str;
 split[3]
 start:-1_split[0];
 new_op:op_d(split[2]);
 num_pos:first where any each .Q.n in\:/: split;
 new_start:first split[except[1 3;num_pos]];
 /'break;
 if[and[new_op~(),"+";num_pos=1];:new_start,":",split[num_pos],"-",start]
 new_str:new_start,":",start,new_op,split num_pos;new_str
 };

// solve for the first variable in root eq;
solve_seed:{[str]
 split:" " vs str;
 num_pos:first where any each .Q.n in\:/: split;
 get raze split[except[1 3;num_pos]],":",split[num_pos]};

//solve_seed root_string;
//(eval_21 each)/[solver each string except[`$gg;`$root_string]];"j"$humn;
//now we can go again to solve

//Day 9
x:" " vs' read0 `:day9.txt;
f:{[d;s]};
h:{[d;s] T,:enlist last[T]+d-s};
g:{[d;s] T,:enlist last[T]+s};
tail_map:(0 0;0 1;1 1;0 2;1 2)!(f;f;f;g;h);
head_map:"RLUD"!(0 1;0 -1;1 0;-1 0);
T:enlist H:1000 1000;

take_a_step:{[step]
 //step:head_map first move;
 show step;
 H+:step;

 tail_map[asc abs diff][diff:H-last[T];step];
 };
 
 take_all_steps:{[move;num]
  num:"I"$first num;
  step:head_map first move;
  //'break;
  //show step;
  take_a_step each num#enlist step};
  
//take_all_steps each x:" " vs' read0 `:day9b.txt;

//Day 12
alphabet:"S",.Q.a,"}";
x:read0 `:day12b.txt;
x:(count first x) cut ssr[raze x;"E";"}"];
steps:(0 1;0 -1;1 0;-1 0);
start:enlist 0 0;
add_possible_steps:{[inp]
 //'break;
 //if[type[inp]=7h;show "shout";.sc.inp::inp];
 if[inp~`dead;:enlist inp];
 current_pos:last inp;
 val:.[x;current_pos];
 if[val~"}";:enlist inp];
 p:current_pos+/:steps;
 p:p where valid_positions each p;
 //poss_vals:.[x;] each poss_positions;
 p:p where (.[x;] each p) in\: alphabet til 2+alphabet?val;
 //'break;
 p:p gr max key gr:group .[x;] each p;
 //'break;
 //p:p where (.[x;] each p) in\: alphabet[(c+1;c-1;c:alphabet?val)];
 p:p where not p in\: inp;
 if[not count p;:enlist `dead];
 inp,/:enlist each p
 }
len:count flip x;
width:count x;
valid_positions:{[inp] 
 $[or[inp[0] in (-1;width);inp[1] in (-1;len)];0b;1b]}

x_target:x[;y_target:min x?'"}"]?"}";
done_pile:()
tester:{[inp]
 show ("here";inp;count inp);
 if[(x_target;y_target)~inp;:inp];
 /if[3=count inp;:inp];
  p:inp+/:steps;
  p:p where valid_positions each p;
  /p:p where not p in\: inp;
  /l:inp,/:enlist each p;
 done_pile,:enlist inp;
 /.z.s[inp,enlist latest+1 1]
  inp,/:.z.s each p;
 };