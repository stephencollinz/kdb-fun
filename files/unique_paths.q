count_all_paths_recursive:{
  // recursively add number of paths 
  if[any 1=(x;y);:1];
  // Otherwise spawn 3 paths - one up, one right and one diagonally
  :.z.s[x-1;y] + .z.s[x;y-1] + .z.s[x-1;y-1] 
 };

 add_possible_steps:{[all_steps]
 current_step:last all_steps; / get the current step
 if[min(current_step) = n-1;:enlist all_steps];
 xx:@[current_step;;+;] .' (0 1;1 1;(0 1;1)); /get all possible movements
 xx:xx where not (|/) each (-1;n) in/: xx; /exclude steps where we move outside the grid
 all_steps,/:enlist each xx
 };

count_all_paths_iterative:{[]
 //this way should be better if we can loop back on ourselves i.e. we need to check if we've returned to same cell. 
 if[not @[get;`n;0];'"matrix size not defined"];
 count (raze add_possible_steps each)/[enlist enlist 0 0]};
 