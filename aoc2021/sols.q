/Day 1
count where 0W >': "I"$'read0 `:day1.txt;
//Part 2
count where 0W >': 2_3 msum "I"$'read0 `:day1.txt;

/Day 2
x:" " vs' read0 `:day2.txt;
pos_map:("forward";"up";"down")!(1 0;0 -1;0 1);
pos:0 0;
{[input] position+:pos_map[input[0]]*"I"$input[1]} each x;prd pos;

//Part 2
x:" " vs' read0 `:day2.txt;
pos:0 0 0;
pos_map:("forward";"up";"down")!({[input] (1*input;input*pos[2];0)};{[input](0;0;-1*input)};{[input](0;0;1*input)});
{[input] pos+:pos_map[input[0]] "I"$input[1]} each x;
pos[0]*pos[1];

//Day 3
x:read0 `:day3.txt
gamma:d?'(max) each d:(count ')each (group ')flip "I"$''x;
epsilon:d?'(min) each d:(count ')each (group ')flip "I"$''x;
prd sv[2;]'[(gamma;epsilon)];

//alternate
d:(count ')each (group ')flip "I"$''x;
prd 2 sv' flip d?'(max;min) @\:/: d;

//Part 2
pos:0;
xx:"I"$''read0 `:day3.txt;
oxygen_bit:{[input]
 r:d?max d:desc[key d]#d:count each group flip[input][pos];
 result:input where input[;pos]=r;
 pos+:1;
 result};

 co2_bit:{[input]
 r:d?min d:asc[key d]#d:count each group flip[input][pos];
 result:input where input[;pos]=r;
 pos+:1;
 result};

oxy_rating:first oxygen_bit/[{[output]count[output]>1};xx];
pos:0;
co2_rating:first co2_bit/[{[output]count[output]>1};xx];
prd 2 sv' (oxy_rating;co2_rating);

//Day 4
x:read0 `:day4.txt;
y:(0,group[x]"") _ x;
callouts:get ssr[y[0;0];",";" "];
cards:(get '')  1_'1_y;
check_a_card:{[num;card] any (all ') b,flip b:card in\: num#callouts};
check_all_cards:{[num] not max check_a_card[num;] each cards};
final_num:{x+1}/[check_all_cards;1]
winning_card:first cards where check_a_card[final_num;] each cards;
sum_unmarked:sum except[raze[winning_card];final_num#callouts];
sum_unmarked*callouts[final_num-1];

//Part B
check_all_cards:{[num] 
 c:check_a_card[num;] each cards;
 if[1<count[cards];set[`cards;]cards where not c];
 not min c};

final_num:{x+1}/[check_all_cards;1];
losing_card:raze cards;
sum_unmarked:sum except[raze[losing_card];final_num#callouts];
sum_unmarked*callouts[final_num-1];


//Day 5
x:read0 `:day5.txt;
pairs:(get '') ";" vs' ssr[;",";" "] each ssr[;" -> ";";"] each x;
non_diag_pairs:pairs where diag_check:{[x;y] or[x[1]~y[1];x[0]~y[0]]} .' pairs;
diag_pairs:pairs where not diag_check;
length:1+max raze pairs[;;0];
width:1+max raze pairs[;;1];
grid:length#enlist width#0;

update_grid_non_diag:{[pair] 
 bool_list:0 =(-) . p:desc pair;
 /'break;
 h:g[1]+til 1+(-) . g:p[;b:first where not bool_list];
 k:p[0;first where bool_list];
 add:$[b;k,/:h;h,\:k];
 .[`grid;;(1+)] each add;};

 //Part B
 grid:length#enlist width#0;
get_one_diag:{[row]
 b:row[0]>row[1];
 func:(abs;reverse) b;
 add:row b;
 func add + til 1+ abs (-) . row
 }
update_grid_diag_bad:{[pair]
 l1:$[pair[0;0]>pair[1;0];
        reverse pair[1;0]+til 1+pair[0;0]-pair[1;0];
        pair[0;0]+til 1+pair[1;0]-pair[0;0]];
 l2:$[pair[0;1]>pair[1;1];
        reverse pair[1;1]+til 1+pair[0;1]-pair[1;1];
        pair[0;1]+til 1+pair[1;1]-pair[0;1]];
 //'break;
 .[`grid;;(1+)] each l1,'l2;}
  /add:reverse[c],'c:p[1;0]+til 1+pair[0;0]-pair[1;0];
 /.[`grid;;(1+)] each add};
update_grid_diag:{[pair]
 l1:get_one_diag[pair[;0]];
 l2:get_one_diag[pair[;1]];
 .[`grid;;(1+)] each l1,'l2;
 };


//Day 6
x:read0 `:day6.txt;
x:get ssr[first x;",";" "];
f:{[input] d:input-1;d:@[d;c:group[d][-1];(7+)];d,count[c]#8};
count f/[80;x];

//Part B
dict:count each group x;
start:0^dict til 9;
f:{[input ]d:1 rotate input;d:@[d;6;+;d 8]};
sum f/[256;start];

//Day 7
x:"I"$' "," vs first read0 `:day7.txt;
y first iasc y:(sum ') abs x-/:min[x]+til[1+max[x]-min[x]];

/Part B
summ:sums xx:min[x]+til[1+max[x]-min[x]];
y first iasc y:(sum ') (summ') abs x-/:xx;

//Day 8
x:read0 `:day8.txt;
sum sum 2 3 4 7=\:(count each raze " "vs' last each "|" vs' x);
/Part B
unscrambled_map:("abcefg";"cf";"acdeg";"acdfg";"bcdf";"abdfg";"abdefg";"acf";"abcdefg";"abcdfg");

all_segs:7#.Q.a;
solve_a_line:{[str_list]
 code:" " vs first split:"|" vs str_list;
 get_codes:{[n;c] c where n=count each c}[;code];
 seg_map:all_segs!7#"_";
 /three:code where 3=count each code;
 /two:code where 2=count each code;
 /:code where 2=count each code;
 seg_map["a"]:except'[get_codes[3];get_codes[2]][0][0];
 my_bd:except'[get_codes[4];get_codes[2]][0];
 my_cde:raze except[all_segs;] each get_codes[6];
 my_be:where 2=count each group raze except[all_segs;] each get_codes[5];
 seg_map["b"]:inter[my_be;my_bd][0];
 seg_map["d"]:except[my_bd;seg_map["b"]][0];
 seg_map["e"]:except[my_be;seg_map["b"]][0];
 seg_map["c"]:except[my_cde;seg_map["de"]][0];
 seg_map["f"]:except[get_codes[2][0];seg_map["c"]][0];
 seg_map["g"]:except[all_segs;get seg_map][0];
 scrambled_map:asc each seg_map'[unscrambled_map];
 //'break;
 "I"$raze string scrambled_map?1_asc each " " vs last split};

sum solve_a_line each x;

//Day 9
x:"I"$''read0 `:day9.txt;
total:0;
steps:(0 1;0 -1;1 0;-1 0);
len:count[x];
wid:count flip x;                                 
pts:til[len] cross til[wid];
{[pt] if[.[x;pt]<min .[x;] each pt+/:steps;total+:1+.[x;pt]];} each pts;
total;

// Part B
low_pts:pts where {[pt] $[.[x;pt]<min .[x;] each pt+/:steps;1b;0b]} each pts;


f1:{[pt]  
 poss:poss where -1=.[x;pt]-.[x;] each poss:pt+/:steps;
 enlist[pt],poss where not 9=.[x;]each poss};
f1:{[pt]
 enlist[pt],poss where not sum 0N 9=\:.[x;] each poss:pt+/:steps
 }

f0:distinct raze f1 each;
prd 3#desc count each f0/'[(enlist each low_pts)];

//Day 10
x:read0`:day10.txt;
check_a_string:{[str]
 set[`rolling_group_check;group str];
 //r:check_an_index[str;]/[{flag};0];
 r:check_an_index[str;] each til count str;
 if[min r1:r[;0];:()];
  r[;1] first where not r[;0]
 //set[`rolling_index;0];
 };
 
open_set:"[{<(";
close_set:"]}>)";
check_an_index:{[s;n]
 if[n~count[s];:(1b;n+1)];
 if[s[n] in open_set;:(1b;n+1)];
 lo:s loi::max c0 where n>c0:raze rolling_group_check open_set;
 match:?[open_set;lo]~?[close_set;s[n]];
 if[match;
    @[`rolling_group_check;(lo;s[n]);except[;(n;loi)]];
    :(1b;n+1)];
 :(0b;s[n])
  };

sum 57 1197 25137 3*close_set#count each group raze check_a_string each x;


//Part B
c_map:close_set!2 3 4 1;
check_a_string2:{[str]
 set[`rolling_group_check;group str];
 //r:check_an_index[str;]/[{flag};0];
 r:check_an_index[str;] each til count str;
 if[not min r1:r[;0];:0i];
  substr:close_set open_set?str desc raze rolling_group_check;
  set[`subtotal;0];
  {[ch] subtotal*:5;subtotal+:c_map ch} each substr;
  subtotal
 //set[`rolling_index;0];
 };

e:check_a_string2 each x;
e (count e:asc e where e>0) div 2;

//Day 11
grid:"I"$''read0 `:day11.txt;
len:count[grid];
wid:count flip grid;                                 
all_pts:til[len] cross til[wid];
steps:(1 0;1 1;1 -1;0 1;0 -1;-1 -1;-1 0;-1 1);
total_flashes:0;
do_a_octopus_step:{[n]
 set[`done_flashes;()];
 
 grid+:1;
 do_flashes/[find_flashes[]];
 reset_flashes[];
 n+1
 };

reset_flashes:{[]
 c:(where ')grid>=10;
 pts_to_flash:raze til[count c],/:'c;
 .[`grid;;:;0] each pts_to_flash;
 };

find_flashes:{[]
 c:(where ')grid>=10;
 pts_to_flash:raze til[count c],/:'c;
 pts_to_flash:except[pts_to_flash;done_flashes];
 pts_to_flash
 };
do_flashes:{[pts]
 /show count pts;
 /c:(where ')grid>10;
 /pts_to_flash:raze til[count c],/:'c;
 /pts:except[c;done_flashes];
 do_one_flash each pts;
 /done_flashes,:pts;
 find_flashes[]
 };

do_one_flash:{[pt]
 neighbours:inter[pt+/:steps;all_pts];
 .[`grid;;(1+)] each neighbours;
 done_flashes,:enlist[pt];
 total_flashes+:1;
 };


//Part B
do_a_octopus_step/[{all all 0=grid};0];

//Day 12
x:`$'"-" vs' read0`:day12.txt;
cave_map:()!();
{[k;v] @[`cave_map;k;,;v];@[`cave_map;v;,;k]} .'  x;
@[`cave_map;key[cave_map];except[;`start]];
small_caves:key[cave_map] where (all ') string[key[cave_map]] in\: .Q.a;
big_caves:key[cave_map] where not (all ') string[key[cave_map]] in\: .Q.a;
small_caves:except[small_caves;`end];
cave_move:{[path]
 l:last path;
 if[l~`end;:enlist path];
 no_good:inter[small_caves;path];
 poss_paths:except[cave_map[l];no_good];
 /poss_paths:except[poss_paths;`start];

 path,/:poss_paths
 };

cave_paths:raze cave_move each;
count cave_paths/[enlist `start];

/Part B
cave_move2:{[path]
 l:last path;
 if[l~`end;:enlist path];
 no_good:inter[small_caves;path];
 path_wb:except[path;big_caves];
 poss_paths:cave_map[l];
 if[count[path_wb]>count[distinct[path_wb]];
       poss_paths:except[cave_map[l];no_good]];
 /poss_paths:except[poss_paths;`start];

 path,/:poss_paths
 };
cave_paths2:raze cave_move2 each;

count cave_paths2/[enlist enlist `start];

//Day 13
x:read0 `:day13.txt;
pts:get each ssr[;",";" "] each first (0,where[""~/:x]) cut x;
folds:(last each vs[" ";]') 1_last (0,where[""~/:x]) cut x;
len:1+max[pts[;0]];
wid:1+max[pts[;1]];
grid:len#enlist wid#0;
.[`grid;;(1+)] each pts;
grid0:flip grid;

do_all_folds:{[str]
 split:"=" vs str;
 axis:split[0];
 n:"I"$split[1];
 m:$[axis~enlist "y";wid;len];
 l:1+n+til m-n+1;
 /'break
 do_one_fold[axis;;n] each l;
 set[`grid0;$[axis~enlist "y";n#grid0;n#'grid0]];
 /show "done a fold";
 };

do_one_fold:{[ax;orig;ov]
 new:orig-2*orig-ov;
 if[new<0;:()];
 ord:$[ax~enlist "y";(new;::);(::;new)];
 orig:$[ax~enlist "y";(orig;::);(::;orig)];
 
 .[`grid0;ord;+;.[grid0;orig]]};
 
/do_all_folds first folds;
/count where raze 0<grid0
/Part B;
do_all_folds each folds;
({[inp]$[inp~enlist "0";".";"X"]}'') string[grid0];

/Day 14
x:read0 `:day14.txt;
polymer_map:()!();
start:x[0];
{[i;o]polymer_map[enlist i]:enlist o,i[1]} .' vs[" -> ";] each 2_x;
polymer_map[enlist first start]:enlist first start;

polymer_step:{[inp0;inp1] polymer_map[inp1,inp0]};
polymer_step0:{[inp]raze "" polymer_step': inp};
(-) . (max;min) @\: asc count each group polymer_step0/[10;start];


/Part B
polymer_map:()!();
{[i;o]polymer_map[enlist i]:enlist (i[0],o;o,i[1])} .' vs[" -> ";] each 2_x;
polymer_step1:{[] 
 dicts:{[k](enlist k)#polymer_status} each key[polymer_status];
 {[d] polymer_status[first polymer_map[key[d]]]+:first value[d];
   polymer_status[key[d]]-:value[d];} each dicts;};
polymer_status:key[polymer_map]!count[polymer_map]#0;
polymer_status[1_({[x;y] y,x}':) start]+:1;

polymer_step1 each 40#`;
k:distinct raze key[polymer_status];
(-) . (max;min) @\: {sum polymer_status key[polymer_status] where key[polymer_status] like "*",x} each k;


//Day 15

x:"I"$''read0 `:day15.txt;
len:count[x];
wid:count flip x;
pts:til[len] cross til[wid];
start:(0 0;0);
bound_steps:(0 1;1 0);
steps:(0 1;1 0;0 -1;-1 0);
get_step_bound:{[inp] 
 if[inp[0]~(len-1;wid-1);:enlist inp];
 g:inp[0]+/:bound_steps;
 /'break;
 g:g where not (|/) each (-1;len) in/: g;
 //get the min
 g:g enlist first iasc .[x;] each g;
 enlist'[g],'inp[1]+/:.[x;] each g};
bound:(raze get_step_bound each)/[enlist start][0;1];
add_step:{[inp] 
 //if[inp[1]>bound;:()];
 l:last inp[0];
 /if[in]
 if[l~(len-1;wid-1);:enlist inp];
 g:l+/:steps;
 /'break;
 g:g where not (|/) each (-1;len) in/: g;
 g:except[g;inp[0]];
 if[not count g;:()];
 //get the min
 /g:g enlist first iasc .[x;] each g;
 (enlist each inp[0],/:enlist'[g]),'inp[1]+/:.[x;] each g};
razor:{[chunks;inp] inp:raze inp;.sc.inp::inp;inp:inp where inp[;1]<=bound;inp (min(chunks;count inp))#iasc inp[;1]};
f2:razor[50000;] add_step each;
f3:raze add_step each;

start:(enlist 0 0;0);

add_step2:{
  // recursively add number of paths 
  if[any len=(x;y);:.[grid;(x;y)]];
  // Otherwise spawn 3 paths - one up, one right and one diagonally
  :.z.s[x-1;y] + .z.s[x;y-1] + .z.s[x-1;y-1] 
 };


// Day 17
checker:{[d] l:d[`pos];t:not $[(|/) (l[0]>309;l[1]<-76;r:(&/) l within flip (287 309;-76 -48));1b;0b];if[not t;show n;n+:1;if[r;m+:1]];t};
do_a_move:{[dict] dict:@[dict;`pos;:;dict[`pos]+dict[`vel]];dict:@[dict;`vel;change_vol]}
change_vol:{[v] v-(signum[v[0]];1)};
/do_a_move/[checker;] each {[inp]`pos`vel!(0 0;inp)} each (til[320]) cross (til[5000]-90);


// Day 20
x:read0 `:day20.txt;
image_algo:x[0];
n:1;
input_image:2_x;
bin_dict:(".#")!0 1;
pad_out_image:{[image]
 ex:1;
 c:count[image];
 s:$[n mod 2;".";"#"];
 s^((neg)c+2*ex)$'(c+ex)$'(ex#enlist c#s),image,ex#enlist c#s
 };
/pad_out:"."^-7$'6$'(enlist 5#"."),input_image,enlist 5#"."

steps: -1 0 1 cross -1 0 1;
new_pixel_value:{[grid;pixel]
 s:$[n mod 2;".";"#"];
 new_value:image_algo 2 sv bin_dict s^.[grid;] each pixel +/: steps
 };

run_the_algo:{[image]
 new_image:pad_out_image[image];
 res:c cut new_pixel_value[new_image;] each  a cross a:til c:count[new_image];
 n+:1;
 res
 };

/count where raze "#"=run_the_algo/[50;input_image]
 
//Day 21
n:1;
game_table:([player:`long$()] pos:`long$();score:`long$());
upsert[`game_table;(1;4;0)];
upsert[`game_table;(2;3;0)];
mv_pos:{[pos;mv] g:mod[pos+mv;10];$[not g;g+10;g]};

make_a_move:{[p]
 if[not check_game[];:()];
 mv:mv_die[n];
 .[`game_table;(p;`pos);mv_pos[;mv]];
 .[`game_table;(p;`score);+;game_table[p;`pos]];
 n+:3;
 };
mv_die:{[num]
 g:mod[num+0 1 2;100];
 sum @[g;where 0=g;(100+)]
 }

check_game:{[t]
 /show "here";
 not $[1000<=max exec score from game_table;1b;0b]};
 make_all_moves:{[]
 / show "there";
 p:exec player from game_table;
 make_a_move each p;
 game_table
 };

/make_all_moves/[check_game;`]
/ exec min score from game_table*n-1



// Day 22
 
x_22:read0 `:day22b.txt;
on_cubes:();
switch_a_row:{[str]
 switch:first " " vs str;
 spl:"," vs last " " vs str;
 nums:"J"$'"." vs' last each "=" vs' spl;
 nums:3 cut @[raze[nums];where 50<raze nums;:;50];
 nums:3 cut @[raze[nums];where -50>raze nums;:;-50];
 //'break
 cubes:(cross/) {[p]t:til 1+abs (-) . p[0 2];t+p[0]} each nums;
 $[switch~"on";
       set[`on_cubes;distinct on_cubes,cubes];
       set[`on_cubes;except[on_cubes;cubes]]];};

nums_from_row:{[str]
 witch:first " " vs str;
 spl:"," vs last " " vs str;
 nums:"J"$'"." vs' last each "=" vs' spl;
 nums};

switch_a_row2:{[str]
 switch:first " " vs str;
 spl:"," vs last " " vs str;
 nums:"J"$'"." vs' last each "=" vs' spl;
 /nums:3 cut @[raze[nums];where 50<raze nums;:;50];
 /nums:3 cut @[raze[nums];where -50>raze nums;:;-50];
 /cubes:(cross/) {[p]t:til 1+abs (-) . p[0 2];t+p[0]} each nums;
 cubes:prd {[p] 1+abs (-) . p[0 2]} each nums;
 $[switch~"on";
       set[`on_cubes;on_cubes+cubes];
       set[`on_cubes;on_cubes-cubes]];};

//Day 24
readout:read0 `:day24.txt;
r_y:(where readout like\: "inp*") cut readout;
getter_map:("add";"mul";"div";"mod";"eql")!(enlist "+";enlist "*";"div";"mod";enlist "=");
seed:14#"9";
x:y:z:0;
getter:{[str]
 spl:" " vs str;
 /'break;
 get spl[1],":(",getter_map[spl[0]],") . (",sv[";";(spl[1];spl[2])],")"};


reducer:{[se]{[s]string ("J"$s)-1}/[{[s] $["0" in s;1b;0b]};string$["J";se]-1]};

eval_batch:{[n]
 show n;
 set[`x;0];
 set[`y;0];
 set[`z;0];
 set[`w;"J"$seed[n]];
  getter each 1_r_y[n];
  if[not z;set[`seed;raze string @["J"$'seed;n;-;1]]];
  n+1
   /show (x;y;z);
  };

/do_monad:{[]
/ set[`seed;reducer[seed]];
/ show seed;
/ set[`x;0];
/ set[`y;0];
/ set[`z;0];
 
/ eval_batch each til 14;};

//do_monad/[{[inp]not not z};];
//eval_batch/[{[inp]not not z};0]