.euler.p52.check_52:{not 1=count distinct asc each string x*2+til 5};
{x+1}/[.euler.p52.check_52;1];

.euler.p52.x0:(),/:get each reverse read0 `:0067_triangle.txt;
{[row] c:count .euler.p52.x0[row];{[n;row] .[`.euler.p52.x0;(row;n);+;max .euler.p52.x0[row-1;(n;n+1)]]}[;row] each til c} each 1+til count[.euler.p52.x0]-1;
last .euler.p52.x0;