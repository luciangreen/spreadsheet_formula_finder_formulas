% convert_tokens_to_nested_list(1,1,1,["(",1,"+",1,")"], NestedList).

% NestedList = [[var, 1, 1, 1, _22900, 1, [], [], [], [], []], "+", [var, 1, 1, 1, _23132, 1, [], [], [], [], []]]


% convert_tokens_to_nested_list(1,1,1,["(",1,"+","(",1,"+",1,")",")"], NestedList).

% NestedList = [[var, 1, 1, 1, _37646, 1, [], [], [], [], []], "+", [[var, 1, 1, 1, _37884, 1, [], [], [], [], []], "+", [var, 1, 1, 1, _38116, 1, [], [], [], [], []]]]


convert_tokens_to_nested_list(_T,_R,_C,Tokens, NestedList) :-
 
 /*
 dynamic(ct_t/1),
 retractall(ct_t(_)),
 assertz(ct_t(T)),
 
 dynamic(ct_r/1),
 retractall(ct_r(_)),
 assertz(ct_r(R)),
 
 dynamic(ct_c/1),
 retractall(ct_c(_)),
 assertz(ct_c(C)),
 */
 
 A=Tokens,
 phrase(a(NestedList),A),!.
 
expr(E)-->num(E).
expr(E)-->a(E1),op1(O),a(E2),{E=[E1,O,E2]}.
num(E)-->[V],{

(number1(V,_Token1)->(%ct_t(T),ct_r(R),ct_c(C),
E=V)%[var,T,R,C,_IN,V,[],[],[],[],[]])
;fail%E=V
)
 
}.
op1(O)-->[O],{operators1(Op),string_strings(Op,Ops),member(O,Ops)}.
a(E)-->["("],expr(E),[")"].
a(E)-->expr(E).

