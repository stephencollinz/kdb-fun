get_all_subcontexts:{[context]
    d:where 99 = type each get[context];
    d:sv'[`;context,/:d];
    d:d where {(::)~first get x} each d;
    :$[not count d;context;d]}

get_all_contexts:{(raze get_all_subcontexts each)/[`$".",/:string key `]}