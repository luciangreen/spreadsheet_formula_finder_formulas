% find_sums_in_term([[[1, 1], a], [[1, 3], aa], [[1, 1, 5], d]], [], A).
% A = [[[[1, 1], a], [[1, 3], aa]], [[[1, 1, 5], d]]].

% last coordinate goes up by 2 (room for +)
% these groups are sums in the formula (1+1+1) or (1+1) elsewhere

find_sums_in_term([], F3, F3) :- !.
find_sums_in_term(F1, F3, F33) :-
    sort(F1, F12),
    %F13 = [[Add, _T] | _F4],
    %append(Add2, [_Last], Add),
    %append(Add2, [_], Add3),
    %F1 = F12,
    member([Add3, T2], F12),
    append(Add4, [Last], Add3),
    append(Add4, [_], Add5),
    findall(Add5, member([Add5, _T3], F12), Add61),
    sub_term_wa(Add5, Add61, Formula_Instances1),
    find_2_steps(Last, Formula_Instances1, [], Formula_Instances2),
    foldr(put_sub_term_wa_ae, Formula_Instances2, Add61, F132),
    findall([ZZ, ZZ2], (member(ZZ, F132), member([ZZ, ZZ2], F12)), ZZ3),
    subtract(F1, ZZ3, F35),
	foldr(append, [%F35, %[[Add3, T2]],
	 ZZ3], F34),
	foldr(append, [%F35, %[[Add3, T2]],
	 [ZZ3]], F341),
	 %trace,
	%append(F3, F341, F331),
	append(F3,F341,F331),
    ((sort(F3, L), sort(F341, L)) -> F33=F331;%append(F3,F341,F33);
    find_sums_in_term(F35, F331, F33)), !.

find_2_steps(Last, Formula_Instances1, FI3, Formula_Instances2) :-
    find_first(%[Last2, F14, F15],
               (member([Add, T], Formula_Instances1),
               append(_, [Last], T),
                Last2 is Last + 2,
                delete(Formula_Instances1, [Add, T], F14),
                append(FI3, [[Add, T]], F15))
               %F151
               ),
    %F151 = [Last2, F14, F15],
    find_2_steps(Last2, F14, F15, Formula_Instances2),
    %append(Formula_Instances21, FI3, Formula_Instances2), 
    !.

find_2_steps(_, _, FI3, FI3).
