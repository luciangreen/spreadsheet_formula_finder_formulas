% cgpt

% Main predicate to group consecutive items where the heads increase by 1 and bodies are the same
group_consecutive_items(List, Grouped) :-
    group_consecutive_aux(List, Grouped).

% Auxiliary predicate to process the list
group_consecutive_aux([], []).
group_consecutive_aux([H|T], [Group|Groups]) :-
    collect_consecutive(H, T, Group, Rest),
    group_consecutive_aux(Rest, Groups).

% Helper predicate to collect consecutive elements with the same body and consecutive heads
collect_consecutive(X, [], [X], []).
collect_consecutive([H1, Body1], [[H2, Body2]|T], [ [H1, Body1] | Group], Rest) :-
    Body1 = Body2,
    H2 is H1 + 1,  % Check if the heads are consecutive
    collect_consecutive([H2, Body2], T, Group, Rest).
collect_consecutive([H1, Body1], [[H2, Body2]|T], [[H1, Body1]], [[H2, Body2]|T]) :-
    not((Body1 = Body2, H2 is H1 + 1)).

% Example query
%?- group_consecutive_items([[1,[1,2]],[2,[1,2]],[3,[3]],[5,[3]],[6,[3]]], Result).
